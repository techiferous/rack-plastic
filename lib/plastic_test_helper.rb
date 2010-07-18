require 'rack/mock'
require 'dirb'
require 'colored'

# Mix this module into Test::Unit::TestCase to have access to these
# test helpers when using Test::Unit.
#
module PlasticTestHelper

  # This takes care of the "plumbing" involved in testing your middleware.
  # All you have to provide is an HTML string, the class of
  # your middleware (not the name of your class or an object, but
  # the class itself), and finally some optional options to use when
  # instantiating your middleware class.
  #
  # This method will return the resulting HTML string (the body of the
  # middleware's response).
  #
  # Examples:
  #   process_html(html, Rack::Linkify)
  #   process_html(html, Rack::Linkify, :twitter => true)
  #
  def process_html(html, middleware_class, options={})
    app = lambda { |env| [200, {'Content-Type' => 'text/html'}, html] }
    app2 = middleware_class.new(app, options)
    Rack::MockRequest.new(app2).get('/', :lint => true).body
  end

  # this convenience method makes it easy to test changes to HTML strings.
  #
  def assert_html_equal(expected_html_string, actual_html_string)
    # Nokogiri does not preserve the same whitespace between tags when
    # it processes HTML.  This means we can't do a simple string comparison.
    # However, if we run both the expected HTML string and the actual HTML
    # string through Nokogiri, then the whitespace will be changed in
    # the same way and we can do a simple string comparison.
    expected = Nokogiri::HTML(expected_html_string).to_html
    actual = Nokogiri::HTML(actual_html_string).to_html
    preamble = "\n"
    preamble =  "*****************************************************\n"
    preamble << "* The actual HTML does not match the expected HTML. *\n"
    preamble << "* The differences are highlighted below.            *\n"
    preamble << "*****************************************************\n"
    message = preamble.magenta
    message << Dirb::Diff.new(expected, actual).to_s(:color)
    assert_block(message) { expected == actual }
  end
      
end
