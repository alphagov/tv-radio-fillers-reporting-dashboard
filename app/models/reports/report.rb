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
  
end