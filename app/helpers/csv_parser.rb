require 'csv'
require 'date'
require "logger"
require "fileutils"

class CsvParser

  def parse_row(row)
  end
  
  protected
  def parse_file(file_full_path, log_file_path)
    FileUtils.rm(log_file_path) if File.exists?(log_file_path)
    log = Logger.new(log_file_path)
    log.level = Logger::DEBUG

    raise ArgumentError, "File does not exist", caller if !File.exists?(file_full_path)

    filler = nil
    row_index = 0
    parsed_count = 0
    CSV.foreach(file_full_path, { :encoding => "iso-8859-1:utf-8" }) do |row|
      begin
        self.parse_row(row).save
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