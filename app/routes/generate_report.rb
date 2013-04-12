
get '/tv/generate-report' do  
  erb :generate_report, :locals => { :mode => "tv", :breadcrumbs => get_breadcrumbs_tv([{ :label => "Reports", :link => "/tv/reports"}]), :report_data => get_report_data('tv', params) }
end

get '/radio/generate-report' do
  erb :generate_report, :locals => { :mode => "radio", :breadcrumbs => get_breadcrumbs_radio([{ :label => "Reports", :link => "/radio/reports"}]), :report_data => get_report_data('radio', params) }
end