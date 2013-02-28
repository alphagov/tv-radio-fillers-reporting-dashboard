require_relative '../test_helper.rb'
require_relative '../models/fillerEntry_tests.rb'

class ImportTest < Test::Unit::TestCase
  
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
  
  def test_tv_import_clear
    FillerEntryTest.add_samples
    
    post "/tv/import/clear"
    assert FillerEntry.where(type: 'tv').count == 0
    assert last_response.redirect?
    assert last_response.location.include?('/tv/import')
  end
  
  def test_radio_import_clear
    FillerEntryTest.add_samples
    
    post "/radio/import/clear"
    assert FillerEntry.where(type: 'radio').count == 0
    assert last_response.redirect?
    assert last_response.location.include?('/radio/import')
  end
  
end