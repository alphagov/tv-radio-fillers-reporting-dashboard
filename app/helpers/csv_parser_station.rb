require_relative "csv_parser.rb"
require_relative "../models/station.rb"

class CsvParserStation < CsvParser
  
  LOG_FILE = "logs/CsvParserStation.log"

  def parse_row(row)
    raise ArgumentError, "Too few rows", caller if row.length < 5
    
    Station.new(
     :type => row[0],
     :station_name => row[1],
     :station_type => row[2],
     :station_group => row[3],
     :not_for_profit => row[4].downcase == 'true' ? true : false
    )
  end

end