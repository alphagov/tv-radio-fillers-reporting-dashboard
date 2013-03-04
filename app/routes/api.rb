require 'csv'
require 'json'

get '/api/:mode/download-csv' do
  content_type "text/csv"
  attachment("#{params[:mode]}_report_#{Time.now.strftime('%F_%H:%M')}.csv")
  
  results = query_for_params(params[:mode], params)
  CSV.generate do |csv|
    csv << ['type', 'date', 'time_of_day', 'station_name', 'impact', 'spot_value', 'client_name', 'filler_name', 'campaign_name', 'clock_name', 'not_for_profit_station']
    results.each do |filler|
      csv << [filler.type, filler.date, filler.time_of_day, filler.station_name, filler.impact, filler.spot_value, filler.client_name, filler.filler_name, filler.campaign_name, filler.clock_name, filler.not_for_profit_station]
    end
  end
end

get  '/api/:mode/download-json' do
  content_type :json
  results = query_for_params(params[:mode], params)
  
  results.to_json
end