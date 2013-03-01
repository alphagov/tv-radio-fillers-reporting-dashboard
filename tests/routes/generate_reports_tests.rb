require_relative '../test_helper.rb'
require_relative '../helpers/csv_parser_radio_test.rb'
require_relative '../helpers/csv_parser_tv_test.rb'

class ReportsTest < Test::Unit::TestCase

  def setup
    FillerEntry.delete_all
    
    CsvParserRadioTest.load_sample_file
    CsvParserTvTest.load_sample_file
  end
  
  def teardown
    FillerEntry.delete_all
  end

  def test_results
    results('tv', '')
    results('radio', '')
  end

  def test_no_results
    no_results('tv')
    no_results('radio')
  end
  
  def results(mode, criteria)
    get "/#{mode}/generate-report?#{criteria}"
    assert !last_response.body.include?('No data found for the criteria')
  end

  def no_results(mode)
    get "/#{mode}/generate-report?filler_name=This+will+give+no+results"
    assert last_response.body.include?('No data found for the criteria')
  end

end