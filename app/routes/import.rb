
get '/:mode/import' do
  erb :import, :locals => { :mode => params[:mode], :breadcrumbs => get_breadcrumbs_by_mode(params[:mode], [{ :label => "Import", :link => "/#{params[:mode]}/import"}]) }
end

get '/:mode/import/transmissions' do
  erb :"import/import_transmissions", :locals => { :mode => params[:mode], :breadcrumbs => get_breadcrumbs_by_mode(params[:mode], [{ :label => "Import", :link => "/#{params[:mode]}/import"}, { :label => "Transmissions", :link => "/#{params[:mode]}/import/transmissions"}]) }
end

post '/:mode/import/transmissions' do
  content_type "text/plain"
  
  file_path = params['datafile'][:tempfile].path
  csv_parser = params[:mode] == 'tv' ? CsvParserTv.new : CsvParserRadio.new
  csv_parser.parse_file(file_path)
  
  File.exists?(csv_parser.log_file_path) ? File.read(csv_parser.log_file_path) : "Log not found"
end

post '/:mode/import/transmissions/clear' do
  content_type "text/plain"
  
  Transmission.delete_all(type: params[:mode])
  
  "Cleared all #{params[:mode]} transmission entries"
end