module Breadcrumbs
  def get_breadcrumbs(breadcrumbs_hash_array, add_home_breadcrumb_at_start = true)
    add_home_breadcrumb_at_start ? [{ :label => "Home", :link => "/"}] + breadcrumbs_hash_array : breadcrumbs_hash_array
  end
  def get_breadcrumbs_tv(breadcrumbs_hash_array = [])
    get_breadcrumbs([{ :label => "TV", :link => "/tv"}] + breadcrumbs_hash_array)
  end
  def get_breadcrumbs_radio(breadcrumbs_hash_array = [])
    get_breadcrumbs([{ :label => "Radio", :link => "/radio"}] + breadcrumbs_hash_array)
  end
end