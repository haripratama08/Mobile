import 'package:ch_v2_1/LoginPage/beforelogin.dart';
import 'package:ch_v2_1/LoginPage/loginpage.dart';
import 'package:ch_v2_1/LoginPage/registerpage.dart';
import 'package:ch_v2_1/Menu/Kamera/kamera_utama.dart';
import 'package:ch_v2_1/Menu/Kontrol/kontrol_auto.dart';
import 'package:ch_v2_1/Menu/Kontrol/kontrol_manual.dart';
import 'package:ch_v2_1/Menu/Kontrol/kontrol_timer.dart';
import 'package:ch_v2_1/Menu/Monitor/monitor_outdoor.dart';
import 'package:ch_v2_1/Menu/Monitor/monitor_utama.dart';
import 'package:ch_v2_1/Menu/Monitor/monitor_indoor.dart';
import 'package:ch_v2_1/Menu/Monitor/monitor_peternakan.dart';
import 'package:ch_v2_1/Menu/Monitor/monitor_perikanan.dart';
import 'package:ch_v2_1/Menu/Monitor/sensor.dart';
import 'package:ch_v2_1/Menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:ch_v2_1/Menu/Kontrol/kontrol_utama.dart';
import 'package:ch_v2_1/Menu/Akun/logout.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Crop Hero',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new LoginPage(),
        '/daftar': (BuildContext context) => new RegisterPage(),
        '/monitor': (BuildContext context) => new Monitor(),
        '/monitor_indoor': (BuildContext context) => new MonitorIndoor(),
        '/monitor_outdoor': (BuildContext context) => new MonitorOutdoor(),
        '/monitor_peternakan': (BuildContext context) =>
            new MonitorPeternakan(),
        '/monitor_perikanan': (BuildContext context) => new MonitorPerikanan(),
        '/kontrol': (BuildContext context) => new KontrolUtama(),
        '/menu': (BuildContext context) => new Menu(),
        '/kontrolmanual': (BuildContext context) => new KontrolManual(),
        '/kontrolauto': (BuildContext context) => new KontrolAuto(),
        '/kontroltimer': (BuildContext context) => new KontrolTimer(),
        '/kamera': (BuildContext context) => new KameraUtama(),
        '/sensor': (BuildContext context) => new SensorData(),
        '/logout': (BuildContext context) => new Logout(),
      },
      home: BeforeLogin(),
      debugShowCheckedModeBanner: false,
    );
  }
}
