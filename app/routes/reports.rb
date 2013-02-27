
get '/tv/reports' do
  erb :import, :locals => { :mode => "tv" }
end

get '/radio/reports' do
  erb :import, :locals => { :mode => "radio" }
end