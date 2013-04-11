require 'date'

class Report
  attr_accessor :mode, :from_date, :to_date
  
  def initialize (mode, from_date, to_date)  
    @mode = mode
    @from_date = from_date
    @to_date = to_date
  end
  
  def generate
    {
      :mode => mode,
      :from_date => @from_date.strftime('%d %B %Y '),
      :to_date => @to_date.strftime('%d %B %Y ')
    }
  end
  
  def self.get_distinct_values_from_hash_array_for_key(hash_array, selector_proc)
    hash_array.inject([]) { |result, hash| result << selector_proc.call(hash) unless result.include?(selector_proc.call(hash)); result }
  end
  
  def self.get_transmissions_summary_for_period_data(mode, from_date, to_date)
    
    map = %Q{
      function() {
        emit(
          {filler_name: this.filler_name, station_name: this.station_name },
          { count: 1, spot_value: this.spot_value}
        );
      }
    }
    
    reduce = %Q{
      function(key, values) {
        var result = { count: 0, spot_value: 0 };
        
        values.forEach(function(value) {
          result.count += value.count;
          result.spot_value += value.spot_value;
        });
        
        return result;
      }
    }
    
    Transmission.where(type: mode, :date.gte => from_date, :date.lte => to_date).map_reduce(map, reduce).out(inline: true)
  end
  
  def self.get_station_name_to_station_map_for_transmissions_summary(transmissions_summary, additional_transmissions_summary = nil)
    all_transmissions_stations = Report.get_stations_for_transmissions_summary(transmissions_summary, additional_transmissions_summary)
    all_transmissions_station_station_name_to_station = {}
    all_transmissions_stations.each { |s| all_transmissions_station_station_name_to_station[s[:station_name]] = s }
    
    all_transmissions_station_station_name_to_station
  end
  
  def self.get_filler_name_to_filler_map_for_transmissions_summary(transmissions_summary, additional_transmissions_summary = nil)
    all_transmissions_fillers = Report.get_fillers_for_transmissions_summary(transmissions_summary, additional_transmissions_summary)
    all_transmissions_filler_filler_name_to_filler = {} 
    all_transmissions_fillers.each { |f| all_transmissions_filler_filler_name_to_filler[f[:filler_name]] = f }
    
    all_transmissions_filler_filler_name_to_filler
  end
  
  def self.get_stations_for_transmissions_summary(transmissions_summary, additional_transmissions_summary = nil)
    station_name_selector = Proc.new { |hash| hash["_id"]["station_name"] }
    station_names = get_distinct_values_from_hash_array_for_key(transmissions_summary, station_name_selector)
    station_names += get_distinct_values_from_hash_array_for_key(additional_transmissions_summary, station_name_selector) unless additional_transmissions_summary.nil?
    
    Station.in(station_name: station_names)
  end
  
  def self.get_fillers_for_transmissions_summary(transmissions_summary, additional_transmissions_summary = nil)
    filler_name_selector = Proc.new { |hash| hash["_id"]["filler_name"] }
    filler_names = get_distinct_values_from_hash_array_for_key(transmissions_summary, filler_name_selector)
    filler_names += get_distinct_values_from_hash_array_for_key(additional_transmissions_summary, filler_name_selector) unless additional_transmissions_summary.nil?
    
    Filler.in(filler_name: filler_names)
  end
  
  def self.get_hash_station_data_for_station_name(station_name_to_station_map, station_name)
    {
      :station_type => station_name_to_station_map[station_name][:station_type],
      :station_name => station_name_to_station_map[station_name][:station_name]
    }
  end
  
  def self.get_hash_filler_data_for_filler_name(filler_name_to_filler_map, filler_name)
    {
      :client_name => filler_name_to_filler_map[filler_name][:client_name],
      :campaign_name => filler_name_to_filler_map[filler_name][:campaign_name],
      :filler_name =>filler_name_to_filler_map[filler_name][:filler_name],
      :coi => filler_name_to_filler_map[filler_name][:coi],
      :length => filler_name_to_filler_map[filler_name][:length]
    }
  end
end