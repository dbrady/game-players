require 'minitest/autorun'
require 'purdytest'

# because Pathname doesn't work like Rails.root :-(
$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), '..'))
