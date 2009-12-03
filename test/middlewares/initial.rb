require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'rack-plastic')

# This middleware emphasizes the first character in every paragraph, not unlike
# the initials in illuminated manuscripts of the Middle Ages.
#
module Rack
  class Initial < Plastic
 
    def change_nokogiri_doc(doc)
      doc.css("p").each do |p|
        p.traverse do |node|
          if node.text?
            if node.content =~ /(.*?)(\S)(.*)/m
              initial_whitespace = $1
              initial_character = $2
              rest_of_text = $3
              update_text(node, initial_whitespace + "openingspantag" + initial_character + 
               "closingspantag" + rest_of_text)
            end
            break
          end
        end
      end
      doc
    end
    
    def change_html_string(html)
      html.gsub!(/openingspantag/, '<span style="font-size: 150%; font-weight: bold;">')
      html.gsub!(/closingspantag/, '</span>')
      html
    end
    
  end
end
