require 'nokogiri'
require File.join(File.dirname(__FILE__), 'plastic_helper')

module Rack

  # If you are creating Rack middleware that changes the HTML response, inherit
  # from Rack::Plastic to get a head start.  Rack::Plastic takes care of the
  # boilerplate Rack glue so that you can focus on simply changing the HTML.
  #
  # There are two ways you can change the HTML: as a Nokogiri document or as
  # a string.  Simply define one of the following methods:
  #
  #   def change_nokogiri_doc(doc)
  #     ... insert code that changes the doc ...
  #     doc
  #   end
  # 
  #   def change_html_string(html)
  #     ... insert code that changes the html string ...
  #     html
  #   end
  #
  # If you define both methods, change_nokogiri_doc will be called first, then
  # the doc will be converted to an HTML string, then the string will be
  # passed to change_html_string.
  #
  # Rack::Plastic also provides some convenience methods for interacting with
  # Rack and Nokogiri.
  #
  class Plastic
 
    # Rack::Plastic provides an initialize method so that your middleware
    # doesn't have to.
    #
    def initialize(app, options = {}) #:nodoc:
      @app = app
      @options = options
      @p = ::Rack::PlasticHelper.new
    end
    
    # Rack::Plastic provides a call method so that your middleware doesn't
    # have to.
    #
    def call(env) #:nodoc:
      @p.send(:handle_request, env, @app, @options, self)
    end
    
    private

    # returns the current request as a Rack::Request object
    #
    def request #:doc:
      @p.request
    end
    
    # returns the hash of options that were given to your middleware
    #
    def options #:doc:
      @p.options
    end

    # a convenience method for adding a new HTML element as the first child
    # of another HTML element
    #
    def add_first_child(parent, new_child) #:doc:
      parent.children.first.add_previous_sibling(new_child)
    end
 
    # a convenience method for quickly creating a new HTML element
    #
    def create_node(doc, node_name, content=nil) #:doc:
      node = Nokogiri::XML::Node.new(node_name, doc)
      node.content = content if content
      node
    end
    
    # Nokogiri's node.content=(text) method automatically HTML escapes the given text.
    # This can cause problems.  This method updates the text of an HTML element
    # without escaping the text.
    #
    def update_text(node, new_text) #:doc:
      node.send(:native_content=, new_text)
    end

  end
end
