module Rack

  # PlasticHelper was created to separate Plastic's implementation from Plastic's
  # interface.
  #
  # This class basically contains all of the Rack code that you'd have to write every
  # time you wanted to write a new middleware that modifies the HTML response.
  #
  module PlasticHelper #:nodoc:

    # Rack::Plastic provides a call method so that your middleware doesn't
    # have to.
    #
    def call(env)
      status, @headers, @body = @app.call(env)
      if html?
        @request = Rack::Request.new(env)

        new_body_string = @body.join("")

        if respond_to? :change_nokogiri_doc
            doc = Nokogiri::HTML(new_body_string)
          doc = change_nokogiri_doc(doc)
          if !doc.is_a?(Nokogiri::XML::Document)
            raise "You must return a Nokogiri::XML::Document object from change_nokogiri_doc."
          end
          new_body_string = doc.to_html
        end

        if respond_to? :change_html_string
          new_body_string = change_html_string(new_body_string)
          raise "You must return a String from change_html_string." unless new_body_string.respond_to?(:to_s)
        end
        update_response_body(new_body_string.to_s)
      end
      [status, @headers, @body]
    end

    private

    def html?
      @headers["Content-Type"] && @headers["Content-Type"].include?("text/html")
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
      @headers['Content-Length'] = Rack::Utils.bytesize(new_body_string).to_s
    end
  end
end
