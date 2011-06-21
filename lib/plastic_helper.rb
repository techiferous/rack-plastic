module Rack

  # PlasticHelper was created to separate Plastic's implementation from Plastic's
  # interface.
  #
  # This class basically contains all of the Rack code that you'd have to write every
  # time you wanted to write a new middleware that modifies the HTML response.
  #
  module PlasticHelper #:nodoc:

    module WithNokogiriDoc
      def nokogiri_doc=(doc)
        @nokogiri_doc = doc
      end
      
      def nokogiri_doc
        @nokogiri_doc
      end
    end

    # Rack::Plastic provides a call method so that your middleware doesn't
    # have to.
    #
    def call(env)
      status, @headers, @body = @app.call(env)
      if html?
        @request = Rack::Request.new(env)
        new_body_string = @body.length == 1 ? @body[0] : @body.join("")

        doc = if new_body_string.is_a?(WithNokogiriDoc)
          new_body_string.nokogiri_doc
        else
          Nokogiri::HTML(new_body_string)
        end
        
        if update_body(doc) != false
          str = doc.to_s
          str.extend WithNokogiriDoc
          str.nokogiri_doc = doc
          update_response_body(str)
        end
      end

      [status, @headers, @body]
    end

    private

    def html?
      @headers["Content-Type"].to_s.include?("text/html")
    end

    def update_response_body(new_body_string)
      # If we're dealing with a Rails response, we don't want to throw the
      # response object away, we just want to update the response string.
      if @body.class.name == "ActionController::Response"
        @body.body = new_body_string
      else
        @body = [new_body_string]
      end

      # we use Rack::Utils.bytesize to avoid incompatibilities between Ruby 1.8 and 1.9
      @headers.update 'Content-Length' => Rack::Utils.bytesize(new_body_string).to_s
    end
  end
end
