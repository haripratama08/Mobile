import 'package:ch_v2_1/LoginPage/loginpage.dart';
import 'package:ch_v2_1/Menu/Kontrol/kontrol_utama.dart';
import 'package:flutter/material.dart';
import 'package:ch_v2_1/Menu/Akun/logout.dart';
import 'package:ch_v2_1/Menu/tambahan/stringcap.dart';
import 'package:ch_v2_1/Menu/Monitor/monitor_semua.dart';

int _selectedIndex;
int count = 0;
int index = 0;
String namaalat;

class Menu extends StatefulWidget {
  final namaalat;
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
      this.namaalat,
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
  Widget route;
  void initState() {
    _onTabItem(index);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  void dispose() {
    _onTabItem(index);
    super.dispose();
  }

  void change(int index) {
    _onTabItem(index);
  }

  void _onTabItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
    setState(() {
      if (index == 0 && widget.index == null ||
          index == 0 && widget.index == 0 ||
          index == null && widget.index == null ||
          index == null && widget.index == 0) {
        setState(() {
          route = Semua();
        });
      } else if (index == 0 && widget.index != null ||
          index == 0 && widget.index != 0) {
        _selectedIndex = widget.index;
        if (widget.index == 0) {
          setState(() {
            route = Semua();
          });
        } else if (widget.index == 1) {
          setState(() {
            route = KontrolUtama();
          });
        } else if (widget.index == 2) {
          setState(() {
            route = Logout();
          });
        }
      } else if (index == 1) {
        setState(() {
          route = KontrolUtama();
        });
      } else if (index == 2) {
        setState(() {
          route = Logout();
        });
      }
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
                onTap: (change)),
          ),
        ));
  }
}
