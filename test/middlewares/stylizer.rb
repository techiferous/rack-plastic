require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'rack-plastic')

# This middleware demonstrates how to add inline CSS styles to the web page.
#
module Rack
  class Stylizer < Plastic
 
    def change_nokogiri_doc(doc)
      doc.at_css("body")["style"] = "font-family: Georgia, serif; font-style: italic;"
      doc.at_css("div#container")["style"] =
       "margin-left:auto;margin-right:auto;width:500px;position:relative"
      doc
    end
    
  end
end
