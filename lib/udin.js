var awsIot = require('aws-iot-device-sdk');
var mysql = require('mysql');
var Database_URL = 'localhost';
var Topic = 'udin';
var device = awsIot.device({
    keyPath: 'Server/private.pem.key',
    certPath: 'Server/cer.pem.crt',
    caPath: 'Server/root.pem',
    host: 'amvmrncux9qfs-ats.iot.ap-southeast-1.amazonaws.com',
    clientId: 'Server2',
});

device.on('connect', function () {
    console.log('connected');
    device.subscribe(Topic, mqtt_subscribe);
});
device.on('message', mqtt_messsageReceived);

function mqtt_subscribe(err, granted) {
    console.log("Subscribed to " + Topic);
    if (err) { console.log(err); }
};
function mqtt_messsageReceived(topic, message, packet) {
    var msg = JSON.parse(message);
    console.log(topic);
    console.log(msg);
    if (40 < msg < 50 && count1 != 1) {
        count1 = 1;
        count2 = 0;



    } else if (50 < msg < 60 && count2 != 1) {
        count2 = 1
        count1 = 0

    } else {

    }
};
