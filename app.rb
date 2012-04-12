require 'presto'
require 'kramdown'
require 'RedCloth'

require 'pdfkit'

PDFKit.configure do |config|
  config.wkhtmltopdf = './bin/wkhtmltopdf-amd64'
#   config.default_options = {
#     :page_size => 'a4',
#     :print_media_type => true
#   }
  # config.default_options = {
  #   :page_size => 'Legal',
  #   :print_media_type => true
  # }
  # config.root_url = "http://localhost" # Use only if your external hostname is unavailable on the server.
end


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
