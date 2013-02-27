require_relative '../test_helper.rb'

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
end