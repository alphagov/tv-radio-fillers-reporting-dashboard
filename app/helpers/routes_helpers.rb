require 'sinatra'
require 'addressable/uri'
require_relative '../../app/models/transmission.rb'

module RoutesHelpers

  REPORTS = [
    { :name => "2B: Client Reports, Transmission by Station and Time of Day"  , :value => "3a_client_reports_transmission_by_filler_and_station" },
    { :name => "2C: Client Reports, Transmission by Time of Day"              , :value => "3a_client_reports_transmission_by_filler_and_station" },
    { :name => "3A: Client Reports, Transmission by Filler and Station"       , :value => "3a_client_reports_transmission_by_filler_and_station" },
    { :name => "4A: Summary Reports, Client by Station Type and Time of Day"  , :value => "3a_client_reports_transmission_by_filler_and_station" },
    { :name => "4B: Summary Reports, Client by Station Type, Theme and Filler", :value => "3a_client_reports_transmission_by_filler_and_station" },
    { :name => "5B: Top Terrestial Transmissions"                             , :value => "3a_client_reports_transmission_by_filler_and_station" },
    { :name => "M1: Clearance Expiry List"                                    , :value => "3a_client_reports_transmission_by_filler_and_station" },
    { :name => "Client Report Set per Client"                                 , :value => "3a_client_reports_transmission_by_filler_and_station" },
    { :name => "Annual Tracking by Client"                                    , :value => "3a_client_reports_transmission_by_filler_and_station" }
  ]

  def is_param_not_nil_empty(params, param_name)
    !params.nil? && !params[param_name].nil? && params[param_name] != ''
  end

  def remove_param_from_url(url, param_name_to_remove)
    uri = Addressable::URI.parse(url)
    
    if !uri.query_values.nil?
      params = uri.query_values
      params.delete param_name_to_remove
      uri.query_values = params
      params.length > 0 ? uri.to_s : uri.to_s.gsub(/[?]$/, '')
    else
      uri.to_s
    end
  end

  def query_for_params(mode, params)
    criteria = Transmission.where(type: mode)
  
    criteria = criteria.where(filler_name: /#{params['filler_name']}/) if is_param_not_nil_empty(params, 'filler_name')
    criteria = criteria.where(station_name: /#{params['station_name']}/) if is_param_not_nil_empty(params, 'station_name')

    if is_param_not_nil_empty(params, 'from_date') && is_param_not_nil_empty(params, 'to_date')
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
    page = is_param_not_nil_empty(params, 'page') ? params['page'].to_i : 1
    
    criteria = query_for_params(mode, params)

    {
      :page => page,
      :page_count => (criteria.count*1.0 / page_size).ceil,
      :results => criteria.paginate(:page => page, :limit => page_size)
    }
  end
end