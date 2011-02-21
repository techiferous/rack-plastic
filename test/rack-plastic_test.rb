$:.unshift(File.expand_path(File.dirname(__FILE__)))
require "test_helper"

module Rack
  class TestMiddleware < Plastic
    def change_nokogiri_doc(doc)
      h1 = create_node(doc, "h1", "Inserted a heading!")
      add_first_child(doc.at_css("body"), h1)
      doc
    end
  end
end

class RackPlasticTest < Test::Unit::TestCase

  def test_modifies_document
    after_html = process_html("<html><body><h1>heading</h1></body></html>", Rack::TestMiddleware)
    assert_html_equal "<html><body><h1>Inserted a heading!</h1><h1>heading</h1></body></html>", after_html
  end

end
