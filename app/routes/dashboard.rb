
get '/tv' do
  erb :dashboard, :locals => { :mode => "tv", :breadcrumbs => [{ :label => "Home", :link => "/"}, { :label => "TV", :link => "/tv"}] }
end

get '/radio' do
  erb :dashboard, :locals => { :mode => "radio", :breadcrumbs => [{ :label => "Home", :link => "/"}, { :label => "Radio", :link => "/radio"}] }
end