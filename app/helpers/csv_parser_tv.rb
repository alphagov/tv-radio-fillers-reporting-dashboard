require_relative "csv_parser.rb"
require_relative "date_parser.rb"
require_relative "../models/transmission.rb"

class CsvParserTv < CsvParser
  include DateParser
  
  LOG_FILE = "logs/CsvParserTv.log"

  INSTRUCTION_TEXT =  'The TV CSV parser assumes the tv filler data comes in the following '\
                      'format: "DATE,TIME,TITLE,CHANNEL", '\
                      'e.g. "06/12/2012,00:37,S COI: FIRE SAFETY - DECK THE HALLS 0037 1:00 COI/PSF5566/060 Y,CTV"'

  def parse_row(row)
    raise ArgumentError, "Too few rows", caller if row.length < 4

    date = parse_date(row[0])

    Transmission.new(
     :type => "tv",
     :date => date,
     :time_of_day => row[1],
     :station_name => row[3],
     :filler_name => row[2]
    )
  end

end