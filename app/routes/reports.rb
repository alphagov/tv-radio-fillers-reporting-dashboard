
get '/tv/reports' do
  erb :reports, :locals => { :mode => "tv" }
end

get '/radio/reports' do
  erb :reports, :locals => { :mode => "radio" }
end