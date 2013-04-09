require_relative '../../app/helpers/routes_helpers.rb'
require_relative '../models/transmission_tests.rb'
require 'test/unit'
require 'date'

class RoutesHelpersTest < Test::Unit::TestCase
  
  def setup
    @object = Object.new
    @object.extend(RoutesHelpers)
    
    Mongoid.load!("mongoid.yml", :test)
    
    Transmission.delete_all
    TransmissionTest.add_samples
  end
  
  def teardown
    Transmission.delete_all
  end
  
  def test_h_encode
    assert_equal("&amp;", @object.h('&'))
  end
  
  def test_is_param_not_nil_empty
    assert(!@object.is_param_not_nil_empty({}, 'param1'), 'should not have found param1')
    assert(!@object.is_param_not_nil_empty({'param1' => ''}, 'param1'), 'param1 was empty')
    assert(@object.is_param_not_nil_empty({'param1' => '1'}, 'param1'), 'should have found param1')
    assert(@object.is_param_not_nil_empty({'param1' => '1', 'param2' => '2'}, 'param2'), 'should have found param2')
  end

  def test_remove_param_from_url_no_params
    url = '/path1/path2'
    assert_equal(url, @object.remove_param_from_url(url, 'param1'))
  end

  def test_remove_param_from_url_with_params
    assert_equal('/path1/path2?param2=2', @object.remove_param_from_url('/path1/path2?param1=1&param2=2', 'param1'))
  end

  def test_remove_param_from_url_remove_single_param_should_remove_question_mark
    assert_equal('/path1/path2', @object.remove_param_from_url('/path1/path2?param1=1', 'param1'))
  end

  def test_query_for_params
    assert_equal(0, @object.query_for_params('none', {}).count)
    assert_equal(1, @object.query_for_params('tv', {}).count)
    assert_equal(1, @object.query_for_params('radio', {}).count)
    
    assert_equal(0, @object.query_for_params('radio', { 'filler_name' => 'none'}).count)
    assert_equal(1, @object.query_for_params('radio', { 'filler_name' => 'filler2'}).count)
    
    assert_equal(0, @object.query_for_params('tv', { 'station_name' => 'none'}).count)
    assert_equal(1, @object.query_for_params('tv', { 'station_name' => 'Test1'}).count)
    
    assert_equal(0, @object.query_for_params('tv', { 'from_date' => Date.new(1999,2,2).strftime('%d/%m/%Y'), 'to_date' => Date.new(1999,2,4).strftime('%d/%m/%Y')}).count)
    assert_equal(1, @object.query_for_params('tv', { 'from_date' => Date.new(2001,2,2).strftime('%d/%m/%Y'), 'to_date' => Date.new(2001,2,4).strftime('%d/%m/%Y')}).count)
  end
  
  def test_get_previous_month_start_date_string
    month = DateTime.now.month-1
    assert_equal("01/#{month < 10 ? '0' : ''}#{month}/#{DateTime.now.year}", @object.get_previous_month_start_date_string, "should return previous month start string")
  end

  def test_get_previous_month_end_date_string
    day = (DateTime.new(DateTime.now.year, DateTime.now.month, 1) - 1.0).day
    month = DateTime.now.month-1
    assert_equal("#{day}/#{month < 10 ? '0' : ''}#{month}/#{DateTime.now.year}", @object.get_previous_month_end_date_string, "should return previous month end string")
  end
  
  def test_get_previous_year_date_string
    assert_equal("01/01/#{DateTime.now.year-1}", @object.get_previous_year_start_date_string, "previous year start string")
  end
  
  def test_get_current_year_date_string
    assert_equal("31/12/#{DateTime.now.year-1}", @object.get_previous_year_end_date_string, "previous year end string")
  end

end