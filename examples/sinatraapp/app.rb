require 'rubygems'
require 'sinatra'
require File.join(File.dirname(__FILE__), '..', 'middlewares', 'initial')
require File.join(File.dirname(__FILE__), '..', 'middlewares', 'intro')
require File.join(File.dirname(__FILE__), '..', 'middlewares', 'l337')
require File.join(File.dirname(__FILE__), '..', 'middlewares', 'stylizer')

# Note that these middlewares will seem to be applied in backwards order.
# In other words, Rack::Stylizer parses the resulting HTML first, then
# passes it to Rack::Initial, then to Rack::L337, and finally to Rack::Intro.

1.times do
  use Rack::Intro
  use Rack::L337
  use Rack::Initial
  use Rack::Stylizer
end

get '/' do
  %Q{
    <!DOCTYPE html
    PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
      <head>
        <title>The Greatest Movie of All Time</title>
      </head>
      <body>
        <div id="container">
          <p>
            What my associate is trying to say is that our new brake pads are really cool.
            You're not even gonna believe it.
          </p>
          <p>
            Like, um, let's say you're driving along
            the road, with your family.<br />
            And you're driving along...la de da...woo...<br />
            And then all of a sudden
            there's a truck tire
            in the middle of the road
            and you hit the brakes.<br />
            Screeeee!
          </p>
          <p>
            Woah, that was close.
          </p>
          <p>
            Now let's see what happens when you're
            driving with "the other guy's brake pads".
          </p>
          <p>
            You're driving along,<br />
            you're driving along,<br />
            and all of a sudden your kids are
            yelling from the back seat:<br />
            "I gotta go to the bathroom, daddy!"<br />
            "Not now, dammit!"<br />
            "Truck tire! I can't stop! Aaaaa! Help!"<br />
            "There's a cliff! Aaaaa!"<br />
            And your family screaming:<br />
            "Oh my God, we're burning alive!"<br />
            "No! I can't feel my legs!"<br />
            Here comes the meat-wagon! Woo woo woo!<br />
            And the medic gets out and says:<br />
            "Oh! My! God!"<br />
            New guy's in the corner puking his guts out:<br />
            Blllleeeeeeeaaaaaaaaaaah!<br />
            Blllleeeeeeeaaaaaaaaaaah!<br />
          </p>
          <p>
            All because you wanna save a coupla extra pennies.
          </p>
          <a href="/more">&laquo; inflict me with more &raquo;</a>
        </div>
      </body>
    </html>
  }
end

get '/more' do
  %Q{
    <!DOCTYPE html
    PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
      <head>
        <title>More of the Greatest Movie of All Time</title>
      </head>
      <body>
        <div id="container">
          <p>
            D+? Oh my God! I passed! I passed! Oh, man i got a D+! I'm gonna graduate!
            I'm gonna graduate! D+!
          </p>
          <p>
            Hey guys, do i look different now that i'm a college grad?
          </p>
          <p>
            Apparently they give a lot fewer D+'s than D-'s.
            It's not a grade they like to give out, i'll tell ya that right now.
          </p>
          <a href="/">&laquo; take me back &raquo;</a>
        </div>
      </body>
    </html>
  }
end
