Introduction
---

markup2pdf converts markdown and textile to a pdf file. 

The reason for this program is that often I've written text in markdown or textile and when somebody asked me about the text I did not have the tools ready to convert the text to pdf. 

Quick Start
---

**Install on heroku**

```bash
$ git clone ...
$ bundle install
$ heroku create
$ git push heroku master
```

Credits
---

The project is based on [Presto](https://github.com/slivu/presto.git). The pdf conversation uses [pdfkit](https://github.com/pdfkit/pdfkit.git), which is based on [wkhtmltopdf](http://code.google.com/p/wkhtmltopdf/).
