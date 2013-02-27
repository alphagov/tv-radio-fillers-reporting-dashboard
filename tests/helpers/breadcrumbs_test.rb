require_relative '../../app/helpers/breadcrumbs.rb'
require 'test/unit'

class BreadcrumbsTest < Test::Unit::TestCase
  
  def setup
    @object = Object.new
    @object.extend(Breadcrumbs)
  end
  
  def test_get_breadcrumbs_has_home_link
    breadcrumbs = @object.get_breadcrumbs([])
    assert breadcrumbs[0][:label] == 'Home'
    assert breadcrumbs[0][:link] == '/'
  end
  
  def test_get_breadcrumbs_appends
    breadcrumbs = @object.get_breadcrumbs([{ :label => "Test1", :link => "/test1"}])
    assert breadcrumbs[1][:label] == 'Test1'
    assert breadcrumbs[1][:link] == '/test1'
  end
  
  def test_get_breadcrumbs_tv
    breadcrumbs = @object.get_breadcrumbs_tv
    assert breadcrumbs[1][:label] == 'TV'
    assert breadcrumbs[1][:link] == '/tv'
  end
  
  def test_get_breadcrumbs_radio
    breadcrumbs = @object.get_breadcrumbs_radio
    assert breadcrumbs[1][:label] == 'Radio'
    assert breadcrumbs[1][:link] == '/radio'
  end
  
end
