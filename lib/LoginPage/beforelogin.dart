import 'package:flutter/material.dart';

class BeforeLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  height: MediaQuery.of(context).size.height / 8,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                  child: Text("Feeling Your Plants",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Mont'))),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 45,
                padding: EdgeInsets.fromLTRB(120, 0, 120, 0),
                child: RaisedButton(
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
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Mont'))),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                  child: Text("Jika belum memiliki akun",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Mont'))),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 45,
                padding: EdgeInsets.fromLTRB(120, 0, 120, 0),
                child: RaisedButton(
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
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Mont'),
                    )),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
