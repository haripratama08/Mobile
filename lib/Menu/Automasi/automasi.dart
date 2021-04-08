import 'dart:async';
import 'package:ch_v2_1/Menu/Automasi/form.dart';
import 'package:ch_v2_1/Sqflite/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ch_v2_1/API/parsing.dart';

class Automasi extends StatefulWidget {
  @override
  _Automasi createState() => _Automasi();
}

class _Automasi extends State<Automasi> with SingleTickerProviderStateMixin {
  DbHelper dbHelper = DbHelper();
  List<SmartTimer> timerList;
  bool loading = false;
  int value = 0;
  TabController _tabController;
  int _selectedIndex = 0;
  int index = 1;
  bool isSwitchedkelembapan = false;

  DateTime pickedDate;
  TimeOfDay time;

  @override
  void initState() {
    updateListView();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    print(_selectedIndex);
    super.dispose();
  }

  int count = 0;
  Future<SmartTimer> navigateToEntryForm(
      BuildContext context, SmartTimer timer) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(timer);
    }));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    if (timerList == null) {
      timerList = [];
    }

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green[900],
          child: Icon(
            Icons.add,
            color: Colors.white,
            // Color(0xFFF7931E),
          ),
          tooltip: 'Tambah Data',
          onPressed: () async {
            var timer = await navigateToEntryForm(context, null);
            if (timer != null) addTimer(timer);
          },
        ),
        body: createListView());
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle1;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green[900],
              child: Icon(
                Icons.timer,
                color: Colors.white,
              ),
            ),
            title: Row(
              children: [
                Text(
                  this.timerList[index].name,
                  style: TextStyle(
                      fontWeight: FontWeight.w300, fontFamily: 'Mont'),
                ),
                SizedBox(width: 10),
                Text(
                  "${timerList[index].time}",
                  style: textStyle,
                ),
              ],
            ),
            subtitle: Text(this.timerList[index].state),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () {
                deleteTimer(timerList[index]);
              },
            ),
            onTap: () async {
              var timer =
                  await navigateToEntryForm(context, this.timerList[index]);
              if (timer != null) editTimer(timer);
            },
          ),
        );
      },
    );
  }

  void addTimer(SmartTimer object) async {
    int result = await dbHelper.insert(object);
    if (result > 0) {
      updateListView();
    }
  }

  //edit contact
  void editTimer(SmartTimer object) async {
    int result = await dbHelper.update(object);
    if (result > 0) {
      updateListView();
    }
  }

  //delete contact
  void deleteTimer(SmartTimer object) async {
    int result = await dbHelper.delete(object.id);
    if (result > 0) {
      updateListView();
    }
  }

  //update contact
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<SmartTimer>> timerListFuture = dbHelper.getContactList();
      timerListFuture.then((timerList) {
        setState(() {
          this.timerList = timerList;
          this.count = timerList.length;
        });
      });
    });
  }
}
