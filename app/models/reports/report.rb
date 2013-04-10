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
  
  def get_distinct_values_from_hash_array_for_key(hash_array, key)
    hash_array.inject([]) { |result, hash| result << hash[key] unless result.include?(hash[key]); result }
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
end