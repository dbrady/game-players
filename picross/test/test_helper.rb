require 'minitest/autorun'
require 'purdytest'

# Because Pathname doesn't work like Rails.root :-(
$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), '..'))
