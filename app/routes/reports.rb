
get '/tv/reports' do
  erb :reports, :locals => { :mode => "tv", :breadcrumbs => get_breadcrumbs_tv([{ :label => "Reports", :link => "/tv/reports"}]), :reports => REPORTS }
end

get '/radio/reports' do
  erb :reports, :locals => { :mode => "radio", :breadcrumbs => get_breadcrumbs_radio([{ :label => "Reports", :link => "/radio/reports"}]), :reports => REPORTS }
end