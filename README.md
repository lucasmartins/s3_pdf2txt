PDF 2 Text conversion service
=============================

Usage
=====

For development test, you might want to use a [Postman](https://chrome.google.com/webstore/detail/postman-rest-client/fdmmgilgnpjigdojojpjoooidkmcomcm?hl=en) Collection from `spec/fixtures/postman.json`

Or plain old cURL:

`curl -X POST -d '{"file_url":"https://s3.amazonaws.com/my-bucket/stub.pdf", "callback_url":"http://63668e1.ngrok.com/mock_callback"}' http://pdf2txt.herokuapp.com/convert`

You should receive an HTTP 200 OK with a JSON body:
```json
{"jid":"32a9f6e544cea4faf867b74b"}
```

If you wanna rule, use [Ngrok](https://ngrok.com/) for the callback testing.