require_relative 'report.rb'

class Report3a < Report

  def initialize (from_date, to_date)  
    super(from_date, to_date)
  end
  
  def generate
    data = super
    data[:station_types] = []
    data
  end
  
end