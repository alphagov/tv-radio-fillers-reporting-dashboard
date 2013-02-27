
get '/tv/import' do
  erb :import, :locals => { :mode => "tv" }
end

get '/radio/import' do
  erb :import, :locals => { :mode => "radio" }
end