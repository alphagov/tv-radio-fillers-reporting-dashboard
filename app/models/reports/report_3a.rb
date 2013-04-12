require_relative 'report.rb'

class Report3a < Report

  def initialize (mode, from_date, to_date)  
    super(mode, from_date, to_date)
  end
  
  def generate
    data = super
    
    previous_period_from_date = Date.new(from_date.year-1, from_date.month, from_date.day)
    previous_period_to_date = Date.new(to_date.year-1, to_date.month, to_date.day)
    
    current_transmissions = Report.get_transmissions_summary_for_period_data(mode, from_date, to_date)
    previous_period_transmissions = Report.get_transmissions_summary_for_period_data(mode, previous_period_from_date, previous_period_to_date)
    
    if ((!current_transmissions.nil? && current_transmissions.count != 0) || 
      (!previous_period_transmissions.nil? && previous_period_transmissions.count != 0))
      station_name_to_station_map = Report.get_station_name_to_station_map_for_transmissions_summary(current_transmissions, previous_period_transmissions)
      filler_name_to_filler_map = Report.get_filler_name_to_filler_map_for_transmissions_summary(current_transmissions, previous_period_transmissions)
      
      if (station_name_to_station_map.keys.length != 0 && 
        filler_name_to_filler_map.keys.length != 0)
        report_data = current_transmissions.collect do |transmission|
          {
            :previous_period => 0,
            :current_period => transmission["value"]["count"],
            :spot_value => transmission["value"]["spot_value"]
          }
          .merge(Report.get_hash_station_data_for_station_name(station_name_to_station_map, transmission["_id"]["station_name"]))
          .merge(Report.get_hash_filler_data_for_filler_name(filler_name_to_filler_map, transmission["_id"]["filler_name"]))
        end
        
        previous_period_transmissions.each do |previous_period_transmission|
          report_data_current_transmission = report_data.find do |current_transmission| 
            current_transmission[:filler_name] == previous_period_transmission["_id"]["filler_name"] && 
            current_transmission[:station_name] == previous_period_transmission["_id"]["station_name"]
          end
          
          if !report_data_current_transmission.nil?
            report_data_current_transmission[:previous_period] = previous_period_transmission["value"]["count"]
          else
            report_data << {
              :previous_period => previous_period_transmission["value"]["count"],
              :current_period => 0,
              :spot_value => 0
            }
            .merge(Report.get_hash_station_data_for_station_name(station_name_to_station_map, previous_period_transmission["_id"]["station_name"]))
            .merge(Report.get_hash_filler_data_for_filler_name(filler_name_to_filler_map, previous_period_transmission["_id"]["filler_name"]))
          end
        end
        
        grouped_station_type = report_data.group_by { |d| d[:station_type] }
        grouped_station_type.each_key do |key_station_type| 
          grouped_station_type_client_name = grouped_station_type[key_station_type].group_by { |d| d[:client_name] }
          grouped_station_type_client_name.each_key do |key_client_name|
            grouped_station_type_client_name[key_client_name] = grouped_station_type_client_name[key_client_name].group_by { |d| d[:campaign_name] }
          end
          grouped_station_type[key_station_type] = grouped_station_type_client_name
        end
        
        data[:station_types] = grouped_station_type
      end
    end
    
    data
  end
  
end