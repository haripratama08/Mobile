import 'package:ch_v2_1/Menu/Kontrol/kontrol_utama.dart';
import 'package:flutter/material.dart';
import 'package:ch_v2_1/LoginPage/loginpage.dart';
import 'package:ch_v2_1/Menu/Akun/logout.dart';
import 'package:ch_v2_1/Menu/tambahan/stringcap.dart';
import 'package:ch_v2_1/Menu/Monitor/monitor_semua.dart';

int index = 0;
int _selectedIndex = 0;
int count = 0;

class Menu extends StatefulWidget {
  final int count;
  final int index;
  final String nama;
  final String email;
  final String user;
  final String uuid;
  final List lokasi;
  final int idlokas;
  final int idhu;
  final int idala;

  const Menu(
      {Key key,
      this.nama,
      this.email,
      this.user,
      this.uuid,
      this.lokasi,
      this.idlokas,
      this.idhu,
      this.idala,
      this.count,
      this.index})
      : super(key: key);
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  Widget route = Semua();
  void initState() {
    Menu();
    _onTabItem(index);
    super.initState();
  }

  void dispose() {
    Menu();
    _onTabItem(index);
    super.dispose();
  }

  void _onTabItem(int index) {
    print("didalam index $index");
    print("widget index ${widget.index}");

    setState(() {
      print("count menu $count");
      print(" index setelah dari kontrol : ${widget.index} ");
      if (widget.index != null && count == null ||
          widget.index != null && count == 0) {
        setState(() {
          index = widget.index;
          count = 1;
        });
        index != 0
            ? setState(() {
                // Navigator.push(context,
                //     new MaterialPageRoute(builder: (context) => new Menu()));
                // count = 0;
                print("index tidak sama dengan 1");
              })
            : setState(() {
                // Navigator.push(context,
                //     new MaterialPageRoute(builder: (context) => new Menu()));
                // count = 0;
                print("index sama dengan 1");
              });
      } else {
        setState(() {
          index = index;
          _selectedIndex = index;
          count = 0;
        });
        print("index $index");
      }

      _selectedIndex = index;

      // if (widget.index == 0) {
      //   route = Semua();
      // } else if (widget.index == 1) {
      //   route = KontrolUtama();
      // } else if (widget.index == 2) {
      //   route = Logout();
      // }

      if (index == 0) {
        route = Semua();
        count = 0;
      } else if (index == 1) {
        count = 0;
        route = KontrolUtama();
      } else if (index == 2) {
        count = 0;
        route = Logout();
      }

      // ketika sudah ready untuk kamera dan automasi
      // if (index == 2) {
      //   route = KameraUtama();
      // }
      // if (index == 3) {
      //   route = Automasi();
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: new PreferredSize(
            child: new Container(
              padding:
                  new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: new Padding(
                padding:
                    const EdgeInsets.only(left: 30.0, top: 20.0, bottom: 20.0),
                child: new Text(
                  '$user'.inCaps,
                  style: new TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Mont',
                    fontWeight: FontWeight.w500,
                    color: Colors.green[900],
                  ),
                ),
              ),
              decoration: new BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 1.5,
                    color: Colors.green[900],
                  ),
                ],
              ),
            ),
            preferredSize: new Size(MediaQuery.of(context).size.width, 150.0),
          ),
          body: route,
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  spreadRadius: 1.5,
                  color: Colors.green[900],
                ),
              ],
            ),
            child: BottomNavigationBar(
              showSelectedLabels: true,
              unselectedItemColor: Colors.green[900],
              selectedItemColor: Color(0xFFF7931E),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.desktop_windows),
                  title: new Text(
                    "Monitor",
                    style: new TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 65,
                      fontFamily: "Mont",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings_remote_rounded),
                  title: new Text(
                    "Kontrol",
                    style: new TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 65,
                      fontFamily: "Mont",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // ketika sudah ready untuk menu kamera dan automasi

                // BottomNavigationBarItem(
                //   icon: Icon(Icons.video_library),
                //   title: new Text(
                //     "Kamera",
                //     style: new TextStyle(
                //       fontSize: MediaQuery.of(context).size.height / 65,
                //       fontFamily: "Mont",
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.smart_button_rounded),
                //   title: new Text(
                //     "Automasi",
                //     style: new TextStyle(
                //       fontSize: MediaQuery.of(context).size.height / 65,
                //       fontFamily: "Mont",
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  title: new Text(
                    "Akun",
                    style: new TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 65,
                      fontFamily: "Mont",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              onTap: _onTabItem,
            ),
          ),
        ));
  }
}
