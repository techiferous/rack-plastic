ActionController::Routing::Routes.draw do |map|
  map.root :controller => "tommy_boy", :action => "index"
  map.connect 'more', :controller => "tommy_boy", :action => "more"
end
