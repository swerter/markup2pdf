require 'app.rb'

app = Presto::App.new
app.mount MyApp do
  view.engine :Haml
end

run app.app