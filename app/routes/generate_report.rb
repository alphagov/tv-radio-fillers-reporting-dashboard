
get '/tv/generate-report' do  
  erb :generate_report, :locals => { :mode => "tv", :breadcrumbs => get_breadcrumbs_tv([{ :label => "Reports", :link => "/tv/reports"}]), :report_data => get_report_data('tv') }
end

get '/radio/generate-report' do
  erb :generate_report, :locals => { :mode => "radio", :breadcrumbs => get_breadcrumbs_radio([{ :label => "Reports", :link => "/radio/reports"}]), :report_data => get_report_data('radio') }
end

def get_report_data(mode)
  begin
    from_date = params[:from_date].nil? ? nil : Date.strptime(params[:from_date], '%d/%m/%Y')
    to_date = params[:to_date].nil? ? nil : Date.strptime(params[:to_date], '%d/%m/%Y')
  rescue ArgumentError
    from_date = nil
    to_date = nil
  end
  
  report_data = from_date.nil? || to_date.nil? ? nil : Report3a.new(mode, from_date, to_date).generate
end