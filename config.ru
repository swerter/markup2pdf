# require 'app.rb'
require File.join(File.dirname(__FILE__), 'app.rb')

app = Presto::App.new
app.mount MyApp do
  view.engine :Haml
end

run app.app