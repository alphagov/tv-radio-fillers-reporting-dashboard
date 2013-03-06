
get '/tv/transmissions' do
  erb :transmissions, :locals => { :mode => "tv", :breadcrumbs => get_breadcrumbs_tv([{ :label => "Transmissions", :link => "/tv/transmissions"}]), :data => query_for_params_with_paging('tv', params) }
end

get '/radio/transmissions' do
  erb :transmissions, :locals => { :mode => "radio", :breadcrumbs => get_breadcrumbs_radio([{ :label => "Transmissions", :link => "/radio/transmissions"}]), :data => query_for_params_with_paging('radio', params) }
end