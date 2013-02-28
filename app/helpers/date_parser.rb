require 'date'

module DateParser

  # This is the list of expected date formats
  DATE_FORMATS = [
    '%d-%b-%y',
    '%d %b %y',
    '%d/%m/%Y',
    '%d-%m-%Y',
    '%d/%m/%y',
    '%d-%m-%y'
  ]

  def parse_date(date_string)
    date = nil
    
    DATE_FORMATS.each do |date_format|
      begin
        date = DateTime.strptime(date_string, date_format)
      rescue
      end
      break if !date.nil?
    end
    
    raise ArgumentError, "Could not parse date: #{date_string}", caller if date.nil?
    date
  end
  
end