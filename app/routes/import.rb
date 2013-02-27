
get '/tv/import' do
  erb :import, :locals => { :mode => "tv", :breadcrumbs => get_breadcrumbs_tv([{ :label => "Import", :link => "/tv/import"}]) }
end

get '/radio/import' do
  erb :import, :locals => { :mode => "radio", :breadcrumbs => get_breadcrumbs_radio([{ :label => "Import", :link => "/radio/import"}]) }
end