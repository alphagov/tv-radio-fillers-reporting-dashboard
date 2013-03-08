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
  
end