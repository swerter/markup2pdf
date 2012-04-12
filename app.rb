require 'presto'
require 'kramdown'
require 'RedCloth'

require 'pdfkit'

class MyApp

    include Presto::Api
    http.map

    http.content_type do
      http.mime_type http.path =~ /converted.pdf$/ ? '.pdf' : '.html'
    end

    def index
      view.render :index
    end

    def converted____pdf
      if http.request_method == 'POST'
        text = http.params[:text]
        converter = http.params[:converter] || 'markdown'

        html_string = case converter
        when 'markdown' then Kramdown::Document.new(text).to_html
        when 'textile' then RedCloth.new(text).to_html
        else
          http.params
        end
        kit = PDFKit.new(html_string)
        pdf = kit.to_pdf
        http.inspect
        pdf


      else
        view.render :index
      end

    end
end

app = Presto::App.new
app.mount MyApp do
  view.engine :Haml
end

app.run :server => :Thin
# app.run :Port => 7777