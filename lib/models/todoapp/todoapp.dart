import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';


import '../../modules/archive/archive.dart';
import '../../modules/done/done.dart';
import '../../modules/tasks/tasks.dart';
import '../../shared/components/components.dart';
import '../../shared/components/components.dart';
import '../../shared/components/const.dart';

class todo extends StatefulWidget {
  @override
  State<todo> createState() => _todoState();
}

class _todoState extends State<todo> {
  var selectedbynv = 0;
  late Database database;
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();


  TextEditingController title = TextEditingController();
  TextEditingController data = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController status = TextEditingController();
  bool bottomsheetisopned = false;
  IconData fbicon = Icons.edit;
  List<String> titles = ["Tasks", "DoneTasks", "Archived Tasks"];
  @override
  void initState() {
    super.initState();
    createDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        title: Text(titles[selectedbynv]),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (bottomsheetisopned) {
            if (formkey.currentState!.validate()) {
              setState(() {
                insertintoDB(
                        date: data.text,
                        status: status.text,
                        time: time.text,
                        title: title.text)
                    .then((value) {
                  GetdataFromDB(database).then((value) {
                    setState(() {tasks = value;});});
                  Navigator.pop(context);
                  bottomsheetisopned = false;
                  fbicon = Icons.edit;
                });
              });
            }
          } else {
            scaffoldkey.currentState!
                .showBottomSheet(
                  (context) => Container(
                    width: double.infinity,
                    // color:Color.fromRGBO(241, 250, 238, 1),
                    //  color: Color.fromRGBO(29, 53, 87, 1),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Form(
                        key: formkey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: TFF(
                                    validate: (value) {
                                      if (value!.isEmpty)
                                        return "this must not empty";
                                    },
                                    keybordlayout: TextInputType.text,
                                    textEditingController: title,
                                    prefex: Icon(Icons.title),
                                    hintontext: "task title"),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: TFF(
                                  validate: (value) {
                                    if (value!.isEmpty)
                                      return "this must not empty";
                                  },
                                  ontap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2024-12-30'),
                                    ).then((value) {
                                      data.text = DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                  keybordlayout: TextInputType.datetime,
                                  textEditingController: data,
                                  prefex: Icon(Icons.calendar_today),
                                  hintontext: "date date",
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: TFF(
                                  keybordlayout: TextInputType.text,
                                  textEditingController: status,
                                  prefex: Icon(Icons.accessibility_sharp),
                                  hintontext: "status title",
                                  validate: (value) {
                                    if (value!.isEmpty)
                                      return "this must not empty";
                                  },
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: TFF(
                                    keybordlayout: TextInputType.datetime,
                                    textEditingController: time,
                                    prefex: Icon(Icons.access_alarms_outlined),
                                    hintontext: "time title",
                                    validate: (value) {
                                      if (value!.isEmpty)
                                        return "this must not empty";
                                    },
                                    ontap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((value) {
                                        setState(() {
                                          time.text = value!.format(context);
                                        });
                                      });
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  elevation: 20,
                )
                .closed
                .then((value) {
              bottomsheetisopned = false;
              setState(() {
                fbicon = Icons.edit;
              });
            });
            setState(() {
              bottomsheetisopned = true;
              fbicon = Icons.add;
            });
          }
        },
        child: Icon(
          fbicon,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedbynv,
          onTap: (index) {
            setState(() {
              selectedbynv = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Tasks"),
            BottomNavigationBarItem(
                icon: Icon(Icons.archive_outlined), label: "archive"),
            BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_outline), label: "Done"),
          ]),
      body:  ConditionalBuilder(
           builder:(context)=>getselectedbuttom[selectedbynv],
        condition: tasks.length>0,
        fallback: (context)=>Center(child: CircularProgressIndicator()),
      ),
    );
  }

  List<Widget> getselectedbuttom = [
    NewTaskScreen(),
    NewArchiveScreen(),
    NewDoneScreen()
  ];

  Future<String> getname() async {
    return "Abdelmoneam";
  }

  void createDB() async {
    database = await openDatabase('to_do.db', version: 1,
        onCreate: (database, virsion) {
      print("database created");
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,data TEXT,time TEXT,status TEXT)')
          .then((value) {
        print("table created");
      }).catchError((error) {
        print("cant create");
      });
    }, onOpen: (database) {
      GetdataFromDB(database).then((value) {
        setState(() {
          tasks = value;
        });

      });
      print('Data base opened');
    });
  }

  Future insertintoDB({
    String? title,
    String? date,
    String? time,
    String? status,
  }) async {
    return await database.transaction((txn) {
      return txn
          .rawInsert('INSERT INTO tasks(title,data,time,status)'
              ' VALUES '
              '("${title}","${date}","${time}","${status}" )')
          .then((value) {
        print('$value inserted successfully');
      }).catchError((error) {
        print('cant insert this record');
      });
    });
  }

  Future<List<Map>> GetdataFromDB(Database database) async {
    return await database.rawQuery('SELECT * FROM tasks');
  }
}
