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
        new_body_string = @body.length == 1 ? @body[0] : @body.join("")

        if respond_to? :change_nokogiri_doc
          doc = if new_body_string.is_a?(XmlString) 
            STDERR.puts "Found Nokogiri doc"
            new_body_string.dom
          else
            Nokogiri::HTML(new_body_string)
          end
          
          doc = change_nokogiri_doc(doc)
          if !doc.is_a?(Nokogiri::XML::Document)
            raise "You must return a Nokogiri::XML::Document object from change_nokogiri_doc."
          end
          puts "doc is #{doc}"
          new_body_string = XmlString.new(doc)
        end

        if respond_to? :change_html_string
          new_body_string = change_html_string(new_body_string.to_s).to_s
        end
        update_response_body(new_body_string)
      end

      puts @body.to_s

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
        @body.body = new_body_string.to_s
      else
        @body = [new_body_string.to_s]
      end

      # we use Rack::Utils.bytesize to avoid incompatibilities between Ruby 1.8 and 1.9
      @headers.delete 'Content-Length' #] = Rack::Utils.bytesize(new_body_string).to_s
    end
  end
end

class XmlString < String
  def initialize(dom)
    @dom = dom
  end
  # 
  # def dom=(dom)
  #   @to_s = nil
  #   @dom = dom
  # end
  
  def dom
    @dom
  end
  
  def bytesize
    Rack::Utils.bytesize to_s
  end
  
  def to_s
    @to_s ||= @dom.to_s
  end
end
