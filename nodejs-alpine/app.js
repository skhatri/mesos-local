var PORT= process.env.PORT || 8081;

require('http').createServer(function (request, response) {
   response.writeHead(200, {'Content-Type': 'application/json'});
   response.end(JSON.stringify({"message": "Hello", "time": Date.now()}));
}).listen(PORT);
console.log('Running at http://127.0.0.1:'+PORT);
