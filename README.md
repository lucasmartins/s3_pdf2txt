[ ![Codeship Status for leghoo/s3_pdf2txt](https://codeship.io/projects/5a07c780-c8c6-0131-c52d-16088bffedc0/status?branch=master)](https://codeship.io/projects/22363)
 [![Quality Status](https://codeclimate.com/github/lucasmartins/s3_pdf2txt.png)](https://codeclimate.com/github/lucasmartins/s3_pdf2txt) [![Coverage Status](https://codeclimate.com/github/lucasmartins/s3_pdf2txt/coverage.png)](https://codeclimate.com/github/lucasmartins/s3_pdf2txt)

Amazon S3 PDF 2 Text conversion service
=======================================

What is this?
=============

This is a jRuby service which wraps [Apache's PdfBox](pdfbox.apache.org) - which is awesome BTW - 
within Sinatra. Under the hood it uses Sidekiq do proccess jobs in the background, and Typhoeus to call back the API caller.

**It's all async!**

Usage
=====

If you can take the heat, here it goes.

For development test, you might want to use a [Postman](https://chrome.google.com/webstore/detail/postman-rest-client/fdmmgilgnpjigdojojpjoooidkmcomcm?hl=en) Collection from `spec/fixtures/postman.json`

Or plain old cURL:

```
curl -X POST -d '{"file_url":"https://s3.amazonaws.com/my-bucket/stub.pdf", "callback_url":"http://63668e1.ngrok.com/mock_callback"}' http://pdf2txt.herokuapp.com/convert
```

You should receive an HTTP 200 OK with a JSON body:
```json
{"jid":"32a9f6e544cea4faf867b74b"}
```

If you wanna rule, use [Ngrok](https://ngrok.com/) for the callback testing.
