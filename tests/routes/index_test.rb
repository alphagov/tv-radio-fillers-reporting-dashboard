require_relative '../test_helper.rb'

class IndexTest < Test::Unit::TestCase
  def test_it_says_index
    get "/"
    assert last_response.ok?
    assert last_response.body.include?('href="/tv"')
    assert last_response.body.include?('href="/radio"')
  end
end