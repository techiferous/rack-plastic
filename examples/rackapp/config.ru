require File.join(File.dirname(__FILE__), 'app')
require File.join(File.dirname(__FILE__), '..', 'middlewares', 'initial')
require File.join(File.dirname(__FILE__), '..', 'middlewares', 'intro')
require File.join(File.dirname(__FILE__), '..', 'middlewares', 'l337')
require File.join(File.dirname(__FILE__), '..', 'middlewares', 'stylizer')

# Note that these middlewares will seem to be applied in backwards order.
# In other words, Rack::Stylizer parses the resulting HTML first, then
# passes it to Rack::Initial, then to Rack::L337, and finally to Rack::Intro.

use Rack::Intro
use Rack::L337
use Rack::Initial
use Rack::Stylizer

run App.new
