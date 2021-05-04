var awsIot = require('aws-iot-device-sdk');
var device = awsIot.device({
    keyPath: "sgp/ab0b58ce3a-private.pem.txt",
    certPath: "sgp/ab0b58ce3a-certificate.pem.txt",
    caPath: "root.pem",
    clientId: "control",
    host: "axkpps0upkdjx-ats.iot.ap-southeast-1.amazonaws.com"
});

var serverless = require('serverless-http');
var express = require('express');
var app = express();
var http = require('http').Server(app);
var path = require('path');
var bodyParser = require('body-parser');
var public = path.join(__dirname, 'public');
port = 2000
domain = "localhost:" + port
app.use('/', express.static(public));
app.use(bodyParser.urlencoded({
    extended: true
}));


app.get('/', function (req, res) {
    res.json({
        message: "Welcome to Backend System CropHero"
    });
});


app.get('/control', function (req, res) {
    var topic = req.query.topic,
        message = req.query.message;
    device.on('connect', function () {
    });
    device.publish(topic, message);
    console.log('Published');
    res.json({
        success: "1",
    });
});


http.listen(port, function () {
    console.log('listening on *:', port);
});


module.exports.handler = serverless(app);