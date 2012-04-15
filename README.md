Introduction
---

markup2pdf converts markdown and textile to a pdf file. 

The reason for this program is that often I've written text in markdown or textile and when somebody asked me about the text I did not have the tools ready to convert the text to pdf. You can test it [here](http://afternoon-rain-7399.herokuapp.com).

Quick Start
---

**Install on heroku**

```bash
$ git clone https://github.com/swerter/markup2pdf.git
$ cd markup2pdf/
$ bundle install
$ heroku create --stack cedar
$ git push heroku master
```

Credits
---

The project is based on [Presto](https://github.com/slivu/presto.git). The pdf conversation uses [pdfkit](https://github.com/pdfkit/pdfkit.git), which is based on [wkhtmltopdf](http://code.google.com/p/wkhtmltopdf/).
