
get '/tv/import' do
  erb :import, :locals => { :mode => "tv", :breadcrumbs => get_breadcrumbs_tv([{ :label => "Import", :link => "/tv/import"}]) }
end

get '/radio/import' do
  erb :import, :locals => { :mode => "radio", :breadcrumbs => get_breadcrumbs_radio([{ :label => "Import", :link => "/radio/import"}]) }
end

post '/tv/import' do
  content_type "text/plain"
  
  file_path = params['datafile'][:tempfile].path
  csv_parser = CsvParserTv.new
  csv_parser.parse_tv_file(file_path)
  
  File.exists?(CsvParserTv::CSV_PARSER_TV_LOG) ? File.read(CsvParserTv::CSV_PARSER_TV_LOG) : "Log not found"
end

post '/radio/import' do
  content_type "text/plain"
  
  file_path = params['datafile'][:tempfile].path
  csv_parser = CsvParserRadio.new
  csv_parser.parse_radio_file(file_path)
  
  File.exists?(CsvParserRadio::CSV_PARSER_RADIO_LOG) ? File.read(CsvParserRadio::CSV_PARSER_RADIO_LOG) : "Log not found"
end

post '/tv/import/clear' do
  Transmission.delete_all(type: 'tv')
  redirect "/tv/import?notice=#{URI.escape('Cleared all TV filler entries')}"
end

post '/radio/import/clear' do
  Transmission.delete_all(type: 'radio')
  redirect "/radio/import?notice=#{URI.escape('Cleared all Radio filler entries')}"
end