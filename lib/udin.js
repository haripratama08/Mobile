var awsIot = require('aws-iot-device-sdk');
var mysql = require('mysql2');
var Database_URL = 'localhost';
var client = require('twilio')('AC7dc857ba41d89261a6cee86eb86df3f6', '3ccfad03664f60124e4cc5e8fbbcf99b');
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

var connection = mysql.createConnection({
    host: Database_URL,
    port: 3306,
    user: "root",
    password: "Indofarming4-0",
    database: "okb"
});

connection.connect(function (err) {
    if (err) throw err;
    console.log("Database Connected!");
});


function mqtt_messsageReceived(topic, message, packet) {
    console.log(message);
    let json = JSON.stringify(message.toString('utf8'));
    console.log("--------------------");
    console.log(json);
    var message_str = JSON.parse(message); //parse payload to json format
    console.log("--------------------");
    insert_message(topic, message_str, packet);
    if (json === "reset") {
        console.log("masuk reset");
        insert_message(topic, message_str, packet);
    } else if (json === "undefined") {
        insert_message(topic, message_str, packet);
        console.log("masuk undefined");
    }
    else {
        insert_message(topic, message_str, packet);
        console.log(message_str);
    }
};


function insert_message(topic, message_str, packet) {
    if (typeof message_str === "undefined") {
        console.log("pesan undefined");
    } else if (typeof message_str === "reset") {
        console.log("pesan reset");
    }
    else {
        var nilaipenambahan = message_str;
        console.log('nilai penambahan : ' + nilaipenambahan + '');
        if (nilaipenambahan === 0 || nilaipenambahan === null) {
            console.log("nilai penambahan nol")
        } else {
            connection.query("SELECT * FROM jumlah_minyak WHERE id = 1", function (err, result, fields) {
                if (err) throw err;
                date = new Date();
                console.log(date);
                console.log(result[0].jumlah);
                nilaiakhir = nilaipenambahan + result[0].jumlah;
                process(nilaiakhir, nilaipenambahan, packet);
                var sql = "UPDATE ?? SET ?? = ?, ?? = ? WHERE id = ?";
                var params = ['jumlah_minyak', 'jumlah', nilaiakhir, 'updateAt', date, '1'];
                sql = mysql.format(sql, params);
                connection.query(sql, function (error, results) {
                    if (error) throw error;
                    console.log(results);
                });
            });
        }
    }
};

function process(message, nilaipenambahan, packet) {
    console.log("-----------------------------------------");
    var msg = JSON.parse(message);
    console.log(message);
    console.log(msg);

    var count1 = 0;
    var count2 = 0;

    if (message > 40) {
        if (message < 50) {
            if (nilaipenambahan < (message - 40)) {
                console.log("tidak mendapatkan peringakatn");
            } else {
                client.messages
                    .create({
                        body: 'Jumlah minyak mencapai ' + message + ' liter',
                        from: '+12014845795',
                        to: '+6281281746805'
                    })
                    .then(message => console.log(message.sid)).catch(error => console.log(error));
                console.log("1");
                var count1 = 1;
                var count2 = 0;
                console.log(count1);
            }
        } else if (message > 50) {
            if (nilaipenambahan < (message - 50)) {
                console.log("tidak mendapatkan peringakatn");
            } else {
                client.messages
                    .create({
                        body: 'Jumlah minyak mencapai ' + message + ' liter',
                        from: '+14243810665',
                        to: '+6285771525800'

                    })
                    .then(message => console.log(message.sid)).catch(error => console.log(error));
                var count1 = 0;
                var count2 = 1;
                console.log("2");
                console.log(count2);
            }
        }
        else {
            console.log("tidak memberikan peringakatn");
        }
    }
    else {
        console.log("tidak memberikan peringakatan");
    }
    console.log("-----------------------------------------");
};


