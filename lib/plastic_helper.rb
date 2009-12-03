module Rack

  # PlasticHelper was created to separate Plastic's implementation from Plastic's
  # interface.
  #
  # This class basically contains all of the Rack code that you'd have to write every
  # time you wanted to write a new middleware that modifies the HTML response.
  #
  class PlasticHelper #:nodoc:
    
    def request
      @request
    end
    
    def options
      @options
    end

    private
    
    def handle_request(env, app, options, plastic)
      @app = app
      @options = options
      @request = Rack::Request.new(env)
      status, @headers, @body = @app.call(env)
      if html?
        if plastic.respond_to? :change_nokogiri_doc
            doc = Nokogiri::HTML(body_to_string)
          doc = plastic.send(:change_nokogiri_doc, doc)
          if !doc.is_a?(Nokogiri::XML::Document)
            raise "You must return a Nokogiri::XML::Document object from change_nokogiri_doc."
          end
          new_body_string = doc.to_html
        else
          new_body_string = body_to_string
        end
        if plastic.respond_to? :change_html_string
          new_body_string = plastic.send(:change_html_string, new_body_string)
          if !new_body_string.is_a?(String)
            raise "You must return a String from change_html_string."
          end
        end
        update_response_body(new_body_string)
        update_content_length
      end
      [status, @headers, @body]
    end
    
    def html?
      @headers["Content-Type"] && @headers["Content-Type"].include?("text/html")
    end

    def body_to_string
      s = ""
      @body.each { |x| s << x }
      s
    end
    
    def update_response_body(new_body_string)
      # If we're dealing with a Rails response, we don't want to throw the
      # response object away, we just want to update the response string.
      if @body.class.name == "ActionController::Response"
        @body.body = new_body_string
      else
        @body = [new_body_string]
      end
    end

    def update_content_length
      length = 0
      @body.each do |s|   # we can't use inject because @body may not respond to it
        length += Rack::Utils.bytesize(s)   # we use Rack::Utils.bytesize to avoid
                                            # incompatibilities between Ruby 1.8 and 1.9
      end
      @headers['Content-Length'] = length.to_s
    end
    
  end
end
