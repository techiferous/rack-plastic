class NokogiriString
  attr :nokogiri
  
  def initialize(nokogiri)
    @nokogiri = nokogiri
  end
  
  # A NokogiriString is not really a String, but is good enought 
  # in the Rack context to act like one. 
  def kind_of?(what)
    return true if what == String
    super
  end
  
  def to_str
    @to_str ||= @nokogiri.to_s
  end
  
  def bytesize
    to_str.bytesize
  end
  
  def to_s
    to_str
  end
end

module Rack

  # PlasticHelper was created to separate Plastic's implementation from Plastic's
  # interface.
  #
  # This class basically contains all of the Rack code that you'd have to write every
  # time you wanted to write a new middleware that modifies the HTML response.
  #
  module PlasticHelper #:nodoc:

    # Rack::Plastic provides a call method so that your middleware doesn't have to.
    def call(env)
      status, @headers, @body = @app.call(env)
      if status == 200 && html?
        @request = Rack::Request.new(env)
        body_string = @body.length == 1 ? @body[0] : @body.join("")

        doc = body_string.respond_to?(:nokogiri) ? body_string.nokogiri : Nokogiri::HTML(body_string)
        
        if doc && update_body(doc) != false
          update_response_body(NokogiriString.new(doc))
        end
      end

      [status, @headers, @body]
    end

    private

    def html?
      @headers["Content-Type"].to_s.include?("text/html")
    end

    def update_response_body(body)
      # If we're dealing with a Rails response, we don't want to throw the
      # response object away, we just want to update the response string.
      if @body.class.name == "ActionController::Response"
        @body.body = body
      else
        @body = [body]
      end

      #
      # The content lenght might have changed... but there is Rack::ContentLength to add
      # it later on again.
      @headers.delete 'Content-Length'
    end
  end
end
