require_relative '../test_helper.rb'
require_relative '../helpers/csv_parser_radio_test.rb'
require_relative '../helpers/csv_parser_tv_test.rb'

class ApiTest < Test::Unit::TestCase

  def setup
    FillerEntry.delete_all
    
    CsvParserRadioTest.load_sample_file
    CsvParserTvTest.load_sample_file
  end
  
  def teardown
    FillerEntry.delete_all
  end

  def test_download_csv
    download_csv('tv', 'filler_name=FIRE', 'FIRE SAFETY - DECK THE HALLS')
    download_csv('radio', 'station_name=Absolute', 'Absolute 70s')
  end

  def download_csv(mode, criteria, sample_row_content)
    get "/api/#{mode}/download-csv?#{criteria}"
    assert last_response.content_type.include? 'text/csv'
    assert last_response.body.include?(sample_row_content)
  end

end