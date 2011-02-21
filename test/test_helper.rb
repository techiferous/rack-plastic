require 'test/unit'
$:.unshift(File.expand_path(File.dirname(__FILE__) + "/../lib"))
require 'rack-plastic'
require 'plastic_test_helper'

module Test
  module Unit
    class TestCase
      include PlasticTestHelper
    end
  end
end
