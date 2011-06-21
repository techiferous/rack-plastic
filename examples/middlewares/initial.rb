require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'rack-plastic')

# This middleware emphasizes the first character in every paragraph, not unlike
# the initials in illuminated manuscripts of the Middle Ages.
#
module Rack
  class Initial < Plastic
 
    def update_body(doc)
      doc.css("p").each do |p|
        p.traverse do |node|
          if node.text?
            if node.content =~ /(.*?)(\S)(.*)/m
              initial_whitespace = $1
              initial_character = $2
              rest_of_text = $3
              text = initial_whitespace + '<span style="font-size: 150%; font-weight: bold;">' + initial_character + 
               '</span>' + rest_of_text
              node.replace text
            end
            break
          end
        end
      end
    end
  end
end
