require_relative '../test_helper.rb'

class ReportsTest < Test::Unit::TestCase
  def test_it_ok_for_mode_tv
    it_ok("/tv/reports")
  end
  def test_it_ok_for_mode_radio
    it_ok("/radio/reports")
  end
  
  def test_has_criteria
    has_criteria('tv')
    has_criteria('radio')
  end
  
  def has_criteria(mode)
    get "/#{mode}/reports"
    assert last_response.body.include?('name="report_type"')
  end
end