require_relative '../test_helper.rb'

class TransmissionsPageTest < Test::Unit::TestCase
  
  def setup
    Transmission.delete_all
    
    CsvParserRadioTest.load_sample_file
    CsvParserTvTest.load_sample_file
  end
  
  def teardown
    Transmission.delete_all
  end

  def test_it_ok_for_mode_tv
    it_ok("/tv/transmissions")
  end
  
  def test_it_ok_for_mode_radio
    it_ok("/radio/transmissions")
  end

end