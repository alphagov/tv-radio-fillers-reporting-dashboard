require 'date'

class Report3a
  attr_accessor :from_date, :to_date
  
  def initialize (from_date, to_date)  
    @from_date = from_date
    @to_date = to_date
  end
  
  def generate
    {
      :from_date => @from_date.strftime('%d %B %Y '),
      :to_date => @to_date.strftime('%d %B %Y '),
      :station_types => []
    }
  end
  
end