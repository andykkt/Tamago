// http://ejohn.org/blog/ecmascript-5-strict-mode-json-and-more/
"use strict";

// Optional. You will see this name in eg. 'ps' or 'top' command
process.title = 'test';

const https = require('https');
const fs = require('fs');

const options = {
  key: fs.readFileSync('pockey.pem'),
  cert: fs.readFileSync('poccert.pem')
};

https.createServer(options, function (req, res) {
  res.writeHead(200);
  res.end("hello world\n");
}).listen(8000);