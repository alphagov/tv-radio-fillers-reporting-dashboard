
get '/tv' do
  erb :dashboard, :locals => { :mode => "tv" }
end

get '/radio' do
  erb :dashboard, :locals => { :mode => "radio" }
end