require_relative "csv_parser.rb"
require_relative "../models/filler.rb"

class CsvParserFiller < CsvParser
  
  LOG_FILE = "logs/CsvParserFiller.log"

  def parse_row(row)
    raise ArgumentError, "Too few rows", caller if row.length < 6
    
    Filler.new(
     :type => row[0],
     :filler_name => row[1],
     :coi => row[2],
     :client_name => row[3],
     :campaign_name => row[4],
     :length => row[5].to_i
    )
  end

end