
get '/tv/generate-report' do
  erb :generate_report, :locals => { :mode => "tv", :breadcrumbs => get_breadcrumbs_tv([{ :label => "Reports", :link => "/tv/reports"}]), :data => query_for_params_with_paging('tv', params) }
end

get '/radio/generate-report' do
  erb :generate_report, :locals => { :mode => "radio", :breadcrumbs => get_breadcrumbs_radio([{ :label => "Reports", :link => "/radio/reports"}]), :data => query_for_params_with_paging('radio', params) }
end