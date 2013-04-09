
get '/tv' do
  erb :dashboard, :locals => { :mode => "tv", :breadcrumbs => get_breadcrumbs_tv, :quick_reports => REPORTS }
end

get '/radio' do
  erb :dashboard, :locals => { :mode => "radio", :breadcrumbs => get_breadcrumbs_radio, :quick_reports => REPORTS }
end