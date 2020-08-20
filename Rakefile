require 'bundler'
Bundler.require

require 'opal'
require 'opal-browser'

desc 'Build our app'
task :build do
  Opal.append_path '.'
  File.open('public/app.js', 'w+') do |out|
    out << Opal::Builder.build('app.rb')
  end
end