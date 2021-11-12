require('events').EventEmitter.defaultMaxListeners = 15;


var awsIot = require('aws-iot-device-sdk');
var device = awsIot.device({
    keyPath: 'cert/private1.pem.key',
    certPath: 'cert/cer1.pem.crt',
    caPath: 'cert/root.pem',
    host: 'axkpps0upkdjx-ats.iot.us-east-1.amazonaws.com',
    clientId: 'httpapi',
});

var serverless = require('serverless-http');
var express = require('express');
var app = express();

app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
  });
  
var http = require('http').Server(app);
var path = require('path');
// deprecated
// var bodyParser = require('body-parser');
var public = path.join(__dirname, 'public');
port = 2000
domain = "localhost:" + port
app.use('/', express.static(public));
app.use(express.urlencoded({
    extended: true
}));

app.get('/', function (req, res) {
    res.json({
        message: "Control API Crophero"
    });
});

app.get('/control', function (req, res) {
    var topic = req.query.topic,
        message = req.query.message;
    device.on('connect', function () {
    });
    device.publish(topic, message);
    console.log('Published');
console.log(topic);
console.log(message);
    res.json({
        success: "1",
    });
});

http.listen(port, function () {
    console.log('listening on *:', port);
});


module.exports.handler = serverless(app);