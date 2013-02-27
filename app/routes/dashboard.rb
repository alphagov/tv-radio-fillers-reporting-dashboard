
get '/tv' do
  erb :dashboard, :locals => { :mode => "tv", :breadcrumbs => get_breadcrumbs_tv }
end

get '/radio' do
  erb :dashboard, :locals => { :mode => "radio", :breadcrumbs => get_breadcrumbs_radio }
end