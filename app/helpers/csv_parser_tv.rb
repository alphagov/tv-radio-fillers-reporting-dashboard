require 'csv'
require 'date'
require "logger"
require "fileutils"
require_relative "date_parser.rb"
require_relative "../models/transmission.rb"

class CsvParserTv
  include DateParser
  
  CSV_PARSER_TV_LOG = "logs/CsvParserTv.log"

  INSTRUCTION_TEXT =  'The TV CSV parser assumes the tv filler data comes in the following '\
                      'format: "DATE,TIME,TITLE,CHANNEL", '\
                      'e.g. "06/12/2012,00:37,S COI: FIRE SAFETY - DECK THE HALLS 0037 1:00 COI/PSF5566/060 Y,CTV"'

  def parse_tv_row(row)
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
  
  def parse_tv_file(file_full_path)
    FileUtils.rm(CSV_PARSER_TV_LOG) if File.exists?(CSV_PARSER_TV_LOG)
    log = Logger.new(CSV_PARSER_TV_LOG)
    log.level = Logger::DEBUG

    raise ArgumentError, "File does not exist", caller if !File.exists?(file_full_path)

    filler = nil
    row_index = 0
    parsed_count = 0
    CSV.foreach(file_full_path, { :encoding => "iso-8859-1:utf-8" }) do |row|
      begin
        self.parse_tv_row(row).save
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