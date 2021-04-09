import 'package:flutter/material.dart';
import 'package:ch_v2_1/API/parsing.dart';

class EntryForm extends StatefulWidget {
  final SmartTimer timer;
  EntryForm(this.timer);

  @override
  EntryFormState createState() => EntryFormState(this.timer);
}

//class controller
class EntryFormState extends State<EntryForm> {
  DateTime date;
  String newvalue;
  String state;
  SmartTimer timer;
  String _date = "null";
  String _time = "null";
  DateTime pickedDate;
  TimeOfDay time;
  EntryFormState(this.timer);

  TextEditingController nameController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    //kondisi
    if (timer != null) {
      nameController.text = timer.name;
      stateController.text = timer.state;
    }
    //rubah
    return Scaffold(
        appBar: AppBar(
          title: timer == null ? Text('Tambah') : Text('Rubah'),
          leading: Icon(Icons.keyboard_arrow_left),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nama',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    print(value);
                  },
                ),
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.green[900])),
                child: new DropdownButton<String>(
                  items: <String>['ON', 'OFF'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value,
                          style: TextStyle(color: Colors.green[900])),
                    );
                  }).toList(),
                  onChanged: (newvalue) {
                    setState(() {
                      state = newvalue;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text(
                    "Date: ${pickedDate.year}, ${pickedDate.month}, ${pickedDate.day}"),
                trailing: Icon(Icons.keyboard_arrow_down),
                onTap: _pickDate,
              ),
              ListTile(
                title: Text("Time: ${time.hour}:${time.minute}"),
                trailing: Icon(Icons.keyboard_arrow_down),
                onTap: _pickTime,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    // tombol simpan
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          print("nama $nameController");
                          print("state $state");
                          print("_date $_date");

                          // tambah data
                          timer = SmartTimer(
                              nameController.text, state, "$_date : $_time");

                          // kembali ke layar sebelumnya dengan membawa objek contact
                          Navigator.pop(context, timer);
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    // tombol batal
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Cancel',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 2),
      initialDate: pickedDate,
    );

    if (date != null)
      setState(() {
        pickedDate = date;
        _date = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
  }

  _pickTime() async {
    TimeOfDay t = await showTimePicker(context: context, initialTime: time);
    if (t != null)
      setState(() {
        time = t;
        _time = "${time.hour}/${time.minute}";
      });
  }
}
