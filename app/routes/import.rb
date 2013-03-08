
get '/:mode/import' do
  erb :import, :locals => { :mode => params[:mode], :breadcrumbs => get_breadcrumbs_by_mode(params[:mode], [{ :label => "Import", :link => "/#{params[:mode]}/import"}]) }
end


get '/:mode/import/transmissions' do
  instructions = params[:mode] == 'tv' ? CsvParserTv::INSTRUCTION_TEXT : CsvParserRadio::INSTRUCTION_TEXT
  erb :"import/import_csv", :locals => { :mode => params[:mode], :upload_type => 'Transmissions', :instructions => instructions, :breadcrumbs => get_breadcrumbs_by_mode(params[:mode], [{ :label => "Import", :link => "/#{params[:mode]}/import"}, { :label => "Transmissions", :link => "/#{params[:mode]}/import/transmissions"}]) }
end

post '/:mode/import/transmissions' do
  content_type "text/plain"
  parse_csv(params['datafile'][:tempfile].path, params[:mode] == 'tv' ? CsvParserTv.new : CsvParserRadio.new)
end

post '/:mode/import/transmissions/clear' do
  content_type "text/plain"
  Transmission.delete_all(type: params[:mode])
  "Cleared all #{params[:mode]} transmission entries"
end


get '/:mode/import/stations' do
  instructions = ''
  erb :"import/import_csv", :locals => { :mode => params[:mode], :upload_type => 'Stations', :instructions => instructions, :breadcrumbs => get_breadcrumbs_by_mode(params[:mode], [{ :label => "Import", :link => "/#{params[:mode]}/import"}, { :label => "Stations", :link => "/#{params[:mode]}/import/stations"}]) }
end

post '/:mode/import/stations' do
  content_type "text/plain"
  parse_csv(params['datafile'][:tempfile].path, CsvParserStation.new)
end

post '/:mode/import/stations/clear' do
  content_type "text/plain"
  Station.delete_all(type: params[:mode])
  "Cleared all #{params[:mode]} station entries"
end


get '/:mode/import/fillers' do
  instructions = ''
  erb :"import/import_csv", :locals => { :mode => params[:mode], :upload_type => 'Fillers', :instructions => instructions, :breadcrumbs => get_breadcrumbs_by_mode(params[:mode], [{ :label => "Import", :link => "/#{params[:mode]}/import"}, { :label => "Fillers", :link => "/#{params[:mode]}/import/fillers"}]) }
end

post '/:mode/import/fillers' do
  content_type "text/plain"
  parse_csv(params['datafile'][:tempfile].path, CsvParserFiller.new)
end

post '/:mode/import/fillers/clear' do
  content_type "text/plain"
  Filler.delete_all(type: params[:mode])
  "Cleared all #{params[:mode]} filler entries"
end


def parse_csv(file_path, csv_parser)
  csv_parser.parse_file(file_path)
  File.exists?(csv_parser.log_file_path) ? File.read(csv_parser.log_file_path) : "Log not found"
end