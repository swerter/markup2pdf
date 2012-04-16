require 'presto'
require 'kramdown'
require 'RedCloth'

require 'pdfkit'

require 'rbconfig'

unless RbConfig::CONFIG['host_os'] =~ /darwin/
  PDFKit.configure do |config|
    config.wkhtmltopdf = './bin/wkhtmltopdf-amd64'
    #   config.default_options = {
    #     :page_size => 'a4',
    #     :print_media_type => true
    #   }
    # config.root_url = "http://localhost" # Use only if your external hostname is unavailable on the server.
  end
end


class MyApp

  include Presto::Api
  http.map

  def index
    view.render :index
  end
  
  def debug
    http.params.inspect
  end

  def converted
    if http.request_method == 'POST'
      format = http.params[:format]
      text = http.params[:text]
      converter = http.params[:converter] || 'markdown'
      html_string = to_html(text, converter)
      case format
      when 'HTML' then 
        @text = text
        @html_string = html_string
        view.render :converted
      when 'PDF' then
        http.content_type do
          http.mime_type '.pdf'
        end
        
        kit = PDFKit.new(html_string)
        pdf = kit.to_pdf
        http['Content-Type'] = http.mime_type('.pdf')
        pdf
#         http.inspect
      else
        http.params
      end
    else
      view.render :index
    end
  end


  private

  def to_html(text, converter = 'markdown')
    case converter
    when 'markdown' then Kramdown::Document.new(text).to_html
    when 'textile' then RedCloth.new(text).to_html
    else
      text
    end
  end

end
