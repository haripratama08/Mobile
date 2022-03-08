import 'package:ch_v2_1/Menu/Kontrol/kontrol_utama.dart';
import 'package:ch_v2_1/process/size_config.dart';
import 'package:flutter/material.dart';
import 'package:ch_v2_1/Menu/Akun/logout.dart';
import 'package:ch_v2_1/Menu/tambahan/stringcap.dart';
import 'package:ch_v2_1/Menu/Monitor/monitor_semua.dart';

int indexpage = 1;
int _selectedIndex;
int count = 0;
int index = 0;
String namaalat;
String title;

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
      title = 'Monitoring';
      if (index == 0) {
        setState(() {
          route = Semua();
        });
      } else if (index == 1) {
        setState(() {
          title = 'Kontroling';
          route = KontrolUtama();
        });
      } else if (index == 2) {
        setState(() {
          title = 'Akun';
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
                child: Row(
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        height: getHeight(18),
                        child: Image.asset('asset/img/logocrophero.png')),
                    SizedBox(
                      width: 5,
                    ),
                    Text('${title.inCaps}',
                        style: TextStyle(
                            color: Colors.green[900],
                            fontFamily: 'kohi',
                            fontWeight: FontWeight.bold,
                            fontSize: getHeight(18)))
                  ],
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
              color: Colors.white10,
              boxShadow: [
                BoxShadow(
                  spreadRadius: 1.5,
                  color: Colors.green[900],
                ),
              ],
            ),
            child: BottomNavigationBar(
                iconSize: 35,
                showSelectedLabels: true,
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.green[400],
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.insert_chart), label: ''
                      // title: Text("", style: TextStyle(fontSize: 0)),
                      ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.control_camera), label: ''
                      // title: Text("", style: TextStyle(fontSize: 0)),
                      ),
                  BottomNavigationBarItem(
                      // title: Text("", style: TextStyle(fontSize: 0)),
                      icon: Icon(Icons.account_circle),
                      label: ''),
                ],
                selectedLabelStyle: TextStyle(
                  fontSize: MediaQuery.of(context).size.height / 65,
                  fontFamily: "Kohi",
                  fontWeight: FontWeight.bold,
                ),
                type: BottomNavigationBarType.fixed,
                currentIndex: _selectedIndex,
                onTap: (change)),
          ),
        ));
  }
}
