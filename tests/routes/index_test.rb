require_relative '../test_helper.rb'

class IndexTest < Test::Unit::TestCase
  def test_it_has_links_to_tv_radio
    get "/"
    assert last_response.ok?
    assert last_response.body.include?('href="/tv"')
    assert last_response.body.include?('href="/radio"')
  end
end