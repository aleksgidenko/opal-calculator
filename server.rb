require 'net/http'
require 'socket'
require 'uri'

WEB_ROOT = './public'

CONTENT_TYPE_MAPPING = {
  'html' => 'text/html',
  'js' => 'text/javascript',
  'css' => 'text/css',
  'png' => 'image/png',
  'jpg' => 'image/jpeg'
}
DEFAULT_CONTENT_TYPE = 'application/octet-stream'

def content_type(path)
  ext = File.extname(path).split('.').last
  CONTENT_TYPE_MAPPING.fetch(ext, DEFAULT_CONTENT_TYPE)
end

server = TCPServer.new('localhost', 8080)
puts 'Server running on localhost:8080'

loop do
  socket = server.accept
  request_line = socket.gets
  STDERR.puts request_line

  next if request_line.nil?

  # parse method and path from request line
  request_parts = request_line.split(' ')
  method = request_parts[0]
  path = URI::DEFAULT_PARSER.unescape(URI(request_parts[1]).path)

  path = 'index.html' if path == '/'

  staticfile = File.join(WEB_ROOT, path)
  if File.exist?(staticfile) && !File.directory?(staticfile)
    File.open(staticfile, 'rb') do |file|
      socket.print "HTTP/1.1 200 OK\r\n" +
                   "Content-Type: #{content_type(file)}\r\n" +
                   "Content-Length: #{file.size}\r\n" +
                   "Connection: close\r\n"
      socket.print "\r\n"
      IO.copy_stream(file, socket)
    end
  else

    # 404 - did not match static file or API path
    message = "404 not found\n"
    socket.print "HTTP/1.1 404 Not Found\r\n" +
                "Content-Type: text/plain\r\n" +
                "Content-Length: #{message.size}\r\n" +
                "Connection: close\r\n"
    socket.print "\r\n"
    socket.print message

  end

  socket.close
end
