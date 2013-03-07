require_relative "csv_parser.rb"
require_relative "date_parser.rb"
require_relative "../models/transmission.rb"

class CsvParserRadio < CsvParser
  include DateParser
  
  CSV_PARSER_RADIO_LOG = "logs/CsvParserRadio.log"

  INSTRUCTION_TEXT =  'The radio CSV parser assumes the radio filler data comes in the following '\
                      'format: "TITLE,CHANNEL,IMPACT,DATE,TIME", '\
                      'e.g. "CBO-009-040 ROY UK only FCO website,Viking FM,15596,07-Jan-13,12:40"'

  def parse_row(row)
    raise ArgumentError, "Too few rows", caller if row.length < 5
 
    date = parse_date(row[3])

    Transmission.new(
     :type => "radio",
     :date => date,
     :time_of_day => row[4],
     :station_name => row[1],
     :impact => row[2],
     :filler_name => row[0]
    )
  end
  
  def parse_radio_file(file_full_path)
    parse_file(file_full_path, CSV_PARSER_RADIO_LOG)
  end
  
end