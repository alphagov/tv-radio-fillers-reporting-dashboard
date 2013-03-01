
get '/tv/generate-report' do
  erb :generate_report, :locals => { :mode => "tv", :breadcrumbs => get_breadcrumbs_tv([{ :label => "Reports", :link => "/tv/reports"}]), :data => query_for_params('tv', params) }
end

get '/radio/generate-report' do
  erb :generate_report, :locals => { :mode => "radio", :breadcrumbs => get_breadcrumbs_radio([{ :label => "Reports", :link => "/tv/reports"}]), :data => query_for_params('radio', params) }
end

def query_for_params(mode, params)
  page_size = 50
  page = is_param_not_nil_empty('page') ? params['page'].to_i : 1
  puts page
  criteria = FillerEntry.where(type: mode)

  criteria = criteria.where(filler_name: /#{params['filler_name']}/) if is_param_not_nil_empty('filler_name')
  criteria = criteria.where(station_name: /#{params['station_name']}/) if is_param_not_nil_empty('station_name')

  {
    :page => page,
    :page_count => ((criteria.count)*1.0 / page_size).ceil,
    :results => criteria.paginate(:page => page, :limit => page_size)    
  }
end
