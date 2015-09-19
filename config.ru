# current directory
$LOAD_PATH.unshift(File.dirname(File.expand_path(__FILE__)))

require 'app'
run Komonjo::App
