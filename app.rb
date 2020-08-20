require 'opal'
require 'browser'

$output = ''

def press(val)
  $output += val
  $document['lcd'].value = $output
end

$document.ready do
  $document['.btn1'].on :click do |event|
    press '1'
  end
  $document['.btn2'].on :click do |event|
    press '2'
  end
  $document['.btn3'].on :click do |event|
    press '3'
  end
  $document['.btn4'].on :click do |event|
    press '4'
  end
  $document['.btn5'].on :click do |event|
    press '5'
  end
  $document['.btn6'].on :click do |event|
    press '6'
  end
  $document['.btn7'].on :click do |event|
    press '7'
  end
  $document['.btn8'].on :click do |event|
    press '8'
  end
  $document['.btn9'].on :click do |event|
    press '9'
  end
  $document['.btn0'].on :click do |event|
    press '0'
  end
  $document['.btnminus'].on :click do |event|
    press ' - '
  end
  $document['.btnplus'].on :click do |event|
    press ' + '
  end

  eqBtn = $document['equals']
  eqBtn.on :click do |event|
    press ' = '
  end
end