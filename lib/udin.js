
device
.on('message', function (topic, payload) {
  obj = JSON.parse(payload);
  if (topic == '1CC/M0n1t0r1CC') {
    deviceID = obj.deviceID;
    temperature = obj.temperature;
    humidity = obj.humidity;
    if (humidity == null) {
      console.log("error on humidity");
    } else {
      if (temperature == null) {
        console.log("error on temperature and humidity");
      } else {
        var dateTime = require('node-datetime');
        var dt = dateTime.create();
        var formatted = dt.format('Y-m-d H:M:S');
        var insert = "INSERT INTO ?? (??,??,??,??) VALUES (?,?,?,?)";
        var params = ['monitoring', 'idUser', 'temp', 'humid', 'time', deviceID, temperature, humidity, formatted];
        insert = mysql.format(insert, params);
        connection.query(insert, function (error, results) {
          if (error) throw error;
          console.log("success");
        });
      }
    }
  } else if (topic == '1CC/M0n1t0r1CC&KWH') {

    deviceID = obj.deviceID;
    temperature = obj.temperature;
    humidity = obj.humidity;
    energy = obj.energy;
    power = obj.power;
    var dateTime = require('node-datetime');
    var dt = dateTime.create();
    var formatted = dt.format('Y-m-d H:M:S');

    // monitoring
    var insert = "INSERT INTO ?? (??,??,??,??) VALUES (?,?,?,?)";
    var params = ['monitoring', 'idUser', 'temp', 'humid', 'time', deviceID, temperature, humidity, formatted];
    insert = mysql.format(insert, params);
    connection.query(insert, function (error, results) {
      if (error) throw error;
      console.log("success monitor");
    });

    //kwh
    var insert = "INSERT INTO ?? (??,??,??,??) VALUES (?,?,?,?)";
    var params = ['kwh', 'iDuser', 'power', 'energy', 'tanggal', deviceID, power, energy, formatted];
    insert = mysql.format(insert, params);
    connection.query(insert, function (error, results) {
      if (error) throw error;
      console.log("success kwh");
    });

  } else if (topic == '1CC/C0nf1rm') {

    deviceID = obj.deviceID;
    statusalat = obj.Status;
    console.log(statusalat);
    console.log(deviceID);
    var sql = "UPDATE switch SET state = '" + statusalat + "' WHERE idUser = '" + deviceID + "'";
    connection.query(sql, function (err, result) {
      if (err) throw err;
      console.log(result.affectedRows + " record(s) updated");

    });

    // var insert = "UPDATE ?? SET (??,??) VALUES (?,?)";
    // var params = ['switch', 'idUser', 'state', deviceID, status];
    // insert = mysql.format(insert, params);
    // connection.query(insert, function (error, results) {
    //   if (error) throw error;
    //   console.log("success");
    // });
  } else {
    console.log('error topic');
  }
});
