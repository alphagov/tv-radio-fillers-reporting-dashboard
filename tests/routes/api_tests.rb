require_relative '../test_helper.rb'
require_relative '../helpers/csv_parser_radio_test.rb'
require_relative '../helpers/csv_parser_tv_test.rb'

class ApiTest < Test::Unit::TestCase

  def setup
    Transmission.delete_all
    
    CsvParserRadioTest.load_sample_file
    CsvParserTvTest.load_sample_file
  end
  
  def teardown
    Transmission.delete_all
  end

  def test_download_csv
    download_csv('tv', 'filler_name=FIRE', 'FIRE SAFETY - DECK THE HALLS')
    download_csv('radio', 'station_name=Absolute', 'Absolute 70s')
  end
  
  def test_download_json
    get "/api/tv/download-json?filler_name=FIRE"

    assert_equal 'application/json;charset=utf-8', last_response.content_type
    assert last_response.body.include?('FIRE SAFETY - DECK THE HALLS'), 'does not have sample data'
  end

  def test_generate_report_empty
    get "api/radio/generate-report?report_type=3a_client_reports_transmission_by_filler_and_station&from_date=01%2F01%2F2000&to_date=01%2F01%2F2001"

    assert_equal 'application/json;charset=utf-8', last_response.content_type
    assert last_response.body.include?('"mode":"radio"'), 'does not have mode'
  end

  def download_csv(mode, criteria, sample_row_content)
    get "/api/#{mode}/download-csv?#{criteria}"

    assert last_response.content_type.include? 'text/csv'
    assert last_response.body.include?(sample_row_content)
  end

end