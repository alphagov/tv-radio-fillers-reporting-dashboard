require_relative '../test_helper.rb'
require_relative '../models/transmission_tests.rb'
require_relative '../models/station_tests.rb'
require_relative '../models/filler_tests.rb'
require_relative '../helpers/csv_parser_radio_test.rb'
require_relative '../helpers/csv_parser_tv_test.rb'
require_relative '../helpers/csv_parser_station_test.rb'
require_relative '../helpers/csv_parser_filler_test.rb'

class ImportTest < Test::Unit::TestCase
  
  def teardown
    Transmission.delete_all
  end
  
  
  def test_import_transmissions_it_contains_upload_control
    it_contains_upload_control("tv", "transmissions")
    it_contains_upload_control("radio", "transmissions")
  end
  
  def test_import_transmissions_post
    Transmission.delete_all(type: 'tv')
    
    post "/tv/import/transmissions", "datafile" => Rack::Test::UploadedFile.new(CsvParserTvTest::SAMPLE_FILE_FULL_PATH, "text/csv")
    assert Transmission.where(type: 'tv').count == 10
    
    Transmission.delete_all(type: 'radio')
    
    post "/radio/import/transmissions", "datafile" => Rack::Test::UploadedFile.new(CsvParserRadioTest::SAMPLE_FILE_FULL_PATH, "text/csv")
    assert Transmission.where(type: 'radio').count == 12
  end
  
  def test_import_transmissions_clear
    TransmissionTest.add_samples
    
    post "/radio/import/transmissions/clear"
    assert_equal(0, Transmission.where(type: 'radio').count)
    
    post "/tv/import/transmissions/clear"
    assert_equal(0, Transmission.where(type: 'tv').count)
  end
  
  
  def test_import_stations_it_contains_upload_control
    it_contains_upload_control("tv", "stations")
    it_contains_upload_control("radio", "stations")
  end
  
  def test_import_stations_post
    Station.delete_all(type: 'tv')
    
    post "/tv/import/stations", "datafile" => Rack::Test::UploadedFile.new(CsvParserStationTest::SAMPLE_FILE_FULL_PATH, "text/csv")
    assert Station.where(type: 'tv').count == 2
    
    Station.delete_all(type: 'radio')
    
    post "/radio/import/stations", "datafile" => Rack::Test::UploadedFile.new(CsvParserStationTest::SAMPLE_FILE_FULL_PATH, "text/csv")
    assert Station.where(type: 'radio').count == 2
  end
  
  def test_import_stations_clear
    StationTest.add_samples
    
    post "/radio/import/stations/clear"
    assert_equal(0, Station.where(type: 'radio').count)
    
    post "/tv/import/stations/clear"
    assert_equal(0, Station.where(type: 'tv').count)
  end


  def test_import_fillers_it_contains_upload_control
    it_contains_upload_control("tv", "fillers")
    it_contains_upload_control("radio", "fillers")
  end
  
  def test_import_fillers_post
    Filler.delete_all(type: 'tv')
    
    post "/tv/import/fillers", "datafile" => Rack::Test::UploadedFile.new(CsvParserFillerTest::SAMPLE_FILE_FULL_PATH, "text/csv")
    assert Filler.where(type: 'tv').count == 1
    
    Filler.delete_all(type: 'radio')
    
    post "/radio/import/fillers", "datafile" => Rack::Test::UploadedFile.new(CsvParserFillerTest::SAMPLE_FILE_FULL_PATH, "text/csv")
    assert Filler.where(type: 'radio').count == 1
  end
  
  def test_import_fillers_clear
    FillerTest.add_samples
    
    post "/radio/import/fillers/clear"
    assert_equal(0, Filler.where(type: 'radio').count)
    
    post "/tv/import/fillers/clear"
    assert_equal(0, Filler.where(type: 'tv').count)
  end


  def it_contains_upload_control(mode, upload_type)
    get "/#{mode}/import/#{upload_type}"
    assert last_response.ok?
    assert last_response.body.include?('<input type="file"')
  end
  
end