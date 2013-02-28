
get '/tv/import' do
  erb :import, :locals => { :mode => "tv", :breadcrumbs => get_breadcrumbs_tv([{ :label => "Import", :link => "/tv/import"}]) }
end

get '/radio/import' do
  erb :import, :locals => { :mode => "radio", :breadcrumbs => get_breadcrumbs_radio([{ :label => "Import", :link => "/radio/import"}]) }
end

post '/tv/import/clear' do
  FillerEntry.delete_all(type: 'tv')
  redirect "/tv/import?notice=#{URI.escape('Cleared all TV filler entries')}"
end

post '/radio/import/clear' do
  FillerEntry.delete_all(type: 'radio')
  redirect "/radio/import?notice=#{URI.escape('Cleared all Radio filler entries')}"
end