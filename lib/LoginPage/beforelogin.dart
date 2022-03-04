import 'package:ch_v2_1/process/size_config.dart';
import 'package:flutter/material.dart';

class BeforeLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: new Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("asset/img/bgh.png"), fit: BoxFit.cover)),
        child: Container(
            child: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Center(
                child: Image.asset(
                  "asset/img/logocircle.png",
                  height: SizeConfigs.screenHeight / 10,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                  child: Text("Feeling Your Plants",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: getHeight(15),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Kohi'))),
              SizedBox(
                height: 15,
              ),
              Container(
                height: SizeConfigs.screenHeight / 20,
                padding: EdgeInsets.fromLTRB(120, 0, 120, 0),
                child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        '/login',
                      );
                    },
                    child: Text("Masuk",
                        style: TextStyle(
                            fontSize: getHeight(13),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Kohi'))),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                  child: Text("Jika belum memiliki akun",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: getHeight(12),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Kohi'))),
              SizedBox(
                height: 15,
              ),
              Container(
                height: SizeConfigs.screenHeight / 20,
                padding: EdgeInsets.fromLTRB(120, 0, 120, 0),
                child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(width: 1.5, color: Colors.white)),
                    color: Colors.green[900],
                    onPressed: () {
                      Navigator.pushNamed(context, '/daftar');
                    },
                    child: Text(
                      "Daftar",
                      style: TextStyle(
                          fontSize: getHeight(13),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Kohi'),
                    )),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
