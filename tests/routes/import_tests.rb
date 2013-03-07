require_relative '../test_helper.rb'
require_relative '../models/transmission_tests.rb'
require_relative '../helpers/csv_parser_radio_test.rb'
require_relative '../helpers/csv_parser_tv_test.rb'

class ImportTest < Test::Unit::TestCase
  
  def teardown
    Transmission.delete_all
  end
  
  def test_tv_it_contains_upload_control
    it_contains_upload_control("tv")
  end
  def test_radio_it_contains_upload_control
    it_contains_upload_control("radio")
  end
  def it_contains_upload_control(mode)
    get "/#{mode}/import"
    assert last_response.ok?
    assert last_response.body.include?('<input type="file"')
  end
  
  def test_tv_import_post
    Transmission.delete_all(type: 'tv')
    
    post "/tv/import", "datafile" => Rack::Test::UploadedFile.new(CsvParserTvTest::SAMPLE_FILE_FULL_PATH, "text/csv")
    assert Transmission.where(type: 'tv').count == 10
  end
  
  def test_radio_import_post
    Transmission.delete_all(type: 'radio')
    
    post "/radio/import", "datafile" => Rack::Test::UploadedFile.new(CsvParserRadioTest::SAMPLE_FILE_FULL_PATH, "text/csv")
    assert Transmission.where(type: 'radio').count == 12
  end
  
  def test_tv_import_clear
    TransmissionTest.add_samples
    
    post "/tv/import/clear"
    assert_equal(0, Transmission.where(type: 'tv').count)
    assert last_response.redirect?
    assert last_response.location.include?('/tv/import')
  end
  
  def test_radio_import_clear
    TransmissionTest.add_samples
    
    post "/radio/import/clear"
    assert_equal(0, Transmission.where(type: 'radio').count)
    assert last_response.redirect?
    assert last_response.location.include?('/radio/import')
  end
  
end