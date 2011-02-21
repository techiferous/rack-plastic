gem 'rack', '>= 1.0.0'
gem 'nokogiri', '>= 1.4.0'

group :development do
  gem 'jeweler'
end

group :test do
  gem 'dirb', '2.0.0'
  gem 'colored'
end

group :development, :test do
  gem 'rake'
  if RUBY_VERSION =~ /^1\.9\./
    gem 'ruby-debug19'
  else
    gem 'ruby-debug'
  end
end
