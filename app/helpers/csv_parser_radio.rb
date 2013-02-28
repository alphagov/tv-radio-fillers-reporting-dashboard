require 'csv'
require 'date'
require "logger"
require "fileutils"
require_relative "../models/fillerEntry.rb"

class CsvParserRadio
  
  DATE_FORMAT = '%d-%b-%y'
  CSV_PARSER_RADIO_LOG = "logs/CsvParserRadio.log"

  INSTRUCTION_TEXT =  'The radio CSV parser assumes the radio filler data comes in the following '\
                      'format: "TITLE,CHANNEL,IMPACT,DATE,TIME", '\
                      'e.g. "CBO-009-040 ROY UK only FCO website,Viking FM,15596,07-Jan-13,12:40"'

  def parse_radio_row(row)
    raise ArgumentError, "Too few rows", caller if row.length < 5

    date_string = row[3]
    date = nil
    begin
      date = DateTime.strptime(date_string, DATE_FORMAT)
    rescue Exception => e
      raise ArgumentError, "Could not parse date: #{date_string}", caller
    end

    FillerEntry.new(
     :type => "radio",
     :date => date,
     :time_of_day => row[4],
     :station_name => row[1],
     :impact => row[2],
     :filler_name => row[0]
    )
  end
  
  def parse_radio_file(file_full_path)
    FileUtils.rm(CSV_PARSER_RADIO_LOG) if File.exists?(CSV_PARSER_RADIO_LOG)
    log = Logger.new(CSV_PARSER_RADIO_LOG)
    log.level = Logger::DEBUG

    raise ArgumentError, "File does not exist", caller if !File.exists?(file_full_path)

    filler = nil
    row_index = 0
    parsed_count = 0
    CSV.foreach(file_full_path, { :encoding => "iso-8859-1:utf-8" }) do |row|
      begin
        self.parse_radio_row(row).save
        parsed_count += 1
      rescue Exception => e
        log.info "INVALID ROW: #{row_index} - #{row.to_s} - #{e.message}"
      end

      if row_index % 100 == 0 && row_index > 0
        log.info "Parsed #{row_index} rows"
      end
      row_index += 1
    end
    
    log.info "Finished parsing: parsed #{parsed_count} rows"
  end
  
end