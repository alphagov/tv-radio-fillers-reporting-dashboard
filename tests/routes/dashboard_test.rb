require_relative '../test_helper.rb'

class DashboardTest < Test::Unit::TestCase
  def test_it_has_links_to_import_reports
    get "/tv"
    assert last_response.ok?
    assert last_response.body.include?('href="/tv/import"')
    assert last_response.body.include?('href="/tv/reports"')

    get "/radio"
    assert last_response.ok?
    assert last_response.body.include?('href="/radio/import"')
    assert last_response.body.include?('href="/radio/reports"')
  end
end