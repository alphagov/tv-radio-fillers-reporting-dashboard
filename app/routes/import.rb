
get '/:mode/import' do
  erb :import, :locals => { :mode => params[:mode], :breadcrumbs => get_breadcrumbs_radio([{ :label => "Import", :link => "/#{params[:mode]}/import"}]) }
end

post '/:mode/import' do
  content_type "text/plain"
  
  file_path = params['datafile'][:tempfile].path
  csv_parser = params[:mode] == 'tv' ? CsvParserTv.new : CsvParserRadio.new
  csv_parser.parse_file(file_path)
  
  File.exists?(csv_parser.log_file_path) ? File.read(csv_parser.log_file_path) : "Log not found"
end

post '/:mode/import/clear' do
  Transmission.delete_all(type: params[:mode])
  redirect "/#{params[:mode]}/import?notice=#{URI.escape('Cleared all ' + params[:mode] + ' transmission entries')}"
end