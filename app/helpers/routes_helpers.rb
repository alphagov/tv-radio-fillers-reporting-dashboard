require 'sinatra'
require 'uri'

module RoutesHelpers

  def is_param_not_nil_empty(param_name)
    !params[param_name].nil? && params[param_name] != ''
  end

  def remove_param_from_url(url, param_name_to_remove)
    uri = URI url
    params = Rack::Utils.parse_query uri.query
    params.delete param_name_to_remove
    uri.query = params.to_param
    uri.to_s
  end

  def query_for_params(mode, params)
    criteria = FillerEntry.where(type: mode)
  
    criteria = criteria.where(filler_name: /#{params['filler_name']}/) if is_param_not_nil_empty('filler_name')
    criteria = criteria.where(station_name: /#{params['station_name']}/) if is_param_not_nil_empty('station_name')

    if is_param_not_nil_empty('from_date') && is_param_not_nil_empty('to_date')
      begin
        from_date = DateTime.strptime(params['from_date'], '%d/%m/%Y')
        to_date = DateTime.strptime(params['to_date'], '%d/%m/%Y')
        criteria = criteria.where(:date => { :$gte => from_date, :$lte => to_date })
      rescue
      end
    end

    criteria.asc(:date, :time_of_day)
  end

  def query_for_params_with_paging(mode, params)
    page_size = 50
    page = is_param_not_nil_empty('page') ? params['page'].to_i : 1
    
    criteria = query_for_params(mode, params)
    
    {
      :page => page,
      :page_count => ((criteria.count)*1.0 / page_size).ceil,
      :results => criteria.paginate(:page => page, :limit => page_size)    
    }
  end
end