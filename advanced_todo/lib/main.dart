import 'package:advanced_todo/myapp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:sqflite/sqlite_api.dart';

dynamic database;

class TaskData {
  int? taskid;
  final String tasktitle;
  final String taskdesc;
  final String taskdate;

  TaskData(
      {this.taskid,
      required this.tasktitle,
      required this.taskdesc,
      required this.taskdate});

  Map<String, dynamic> taskMap() {
    return {
      'id': taskid,
      'title': tasktitle,
      'desc': taskdesc,
      'date': taskdate
    };
  }

  @override
  String toString() {
    return "taskid: $taskid,tasktitle:$tasktitle,taskdesc:$taskdesc,taskdate:$taskdate";
  }
}

// delete

Future<void> deletetaskdata(int deleteIndex) async {
  final localDB = await database;

  await localDB.delete(
    "TaskData",
    where: 'id=?',
    whereArgs: [deleteIndex],
  );
}

// update task

Future<void> updatetask(TaskData edittask) async {
  final localDB = await database;

  await localDB.update(
    "TaskData",
    edittask.taskMap(),
    where: 'id =?',
    whereArgs: [edittask.taskid],
  );
}

// insert

Future<void> inserttaskdata(TaskData task) async {
  final localDB = await database;

  localDB.insert(
    "TaskData",
    task.taskMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<TaskData>> getTaskData() async {
  final localDB = await database;

  List<Map<String, dynamic>> listtask = await localDB.query('TaskData');

  return List.generate(listtask.length, (index) {
    return TaskData(
        taskid: listtask[index]["id"],
        tasktitle: listtask[index]["title"],
        taskdesc: listtask[index]["desc"],
        taskdate: listtask[index]['date']);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = await openDatabase(
    join(await getDatabasesPath(), "taskduirsddaatahg.db"),
    version: 1,
    onCreate: (db, version) {
      db.execute(''' CREATE TABLE TaskData(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      desc TEXT,
      date TEXT)''');
    },
  );

  runApp(const myApp());
}



class ToDOListAppModel {
  String titleController;
  String descriptionController;
  String dateController;

  ToDOListAppModel(
      {required this.titleController,
      required this.descriptionController,
      required this.dateController});
}

class advancedto extends StatefulWidget {
  const advancedto({super.key});

  @override
  State<advancedto> createState() => _advancedtodostate();
}

class _advancedtodostate extends State<advancedto> {
  List<Color> colors = [
    const Color.fromRGBO(232, 237, 250, 1),
    const Color.fromRGBO(250, 232, 250, 1),
    const Color.fromRGBO(250, 232, 232, 1),
    const Color.fromRGBO(250, 249, 232, 1),
    const Color.fromRGBO(250, 232, 234, 1),
  ];

  int? editingIndex;
  bool flag = false;
  bool flag1 = false;
  bool flag2 = false;
  int? deleteIndex;
  bool isTaskAvailable = false;
  List<TaskData> todolist = [];

  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController date = TextEditingController();

  // ignore: non_constant_identifier_names
  void BottomSheetPage() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: this.context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: MediaQuery.of(context).viewInsets,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Create Task",
                          style: GoogleFonts.quicksand(
                            textStyle: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Title",
                        style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: TextField(
                          controller: title,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: flag
                                    ? Colors.red
                                    : const Color.fromRGBO(0, 139, 148, 1),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: flag && title.text.trim().isEmpty
                                    ? Colors.red
                                    : const Color.fromRGBO(0, 139, 148, 1),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onChanged: (ValueKey) {
                            if (flag) {
                              setState(() {
                                flag = false;
                                Navigator.pop(context);
                                BottomSheetPage();
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Description",
                        style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Color.fromRGBO(0, 139, 148, 1),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 150,
                        child: TextField(
                          controller: desc,
                          maxLines: 4,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: flag1
                                    ? Colors.red
                                    : const Color.fromRGBO(0, 139, 148, 1),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: flag1
                                    ? Colors.red
                                    : const Color.fromRGBO(0, 139, 148, 1),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onChanged: (ValueKey) {
                            if (flag1) {
                              setState(() {
                                flag1 = false;
                                Navigator.pop(context);
                                BottomSheetPage();
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Date",
                        style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Color.fromRGBO(0, 139, 148, 1),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: TextField(
                            controller: date,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: flag2
                                      ? Colors.red
                                      : const Color.fromRGBO(0, 139, 148, 1),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: flag2
                                      ? Colors.red
                                      : const Color.fromRGBO(0, 139, 148, 1),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: const Icon(
                                Icons.date_range_outlined,
                                color: Color.fromRGBO(0, 0, 0, 0.7),
                              ),
                            ),
                            onChanged: (ValueKey) {
                              if (flag2) {
                                setState(() {
                                  flag2 = false;
                                  Navigator.pop(context);
                                  BottomSheetPage();
                                });
                              }
                            },
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101));
          
                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
          
                                setState(() {
                                  date.text = formattedDate;
                                });
                              }
                            }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(60, 40, 173, 180),
                            fixedSize: const Size(300, 50),
                          ),
                          onPressed: () {
                            
                            textvalidation();
          
                            if (title.text.isEmpty) {
                              flag = true;
                              Navigator.pop(context);
                              BottomSheetPage();
                            } else if (desc.text.isEmpty) {
                              flag1 = true;
                              Navigator.pop(context);
                              BottomSheetPage();
                            } else if (date.text.isEmpty) {
                              flag2 = true;
                              Navigator.pop(context);
                              BottomSheetPage();
                            } else {
                              if (title.text.trim().isNotEmpty &&
                                  desc.text.trim().isNotEmpty &&
                                  date.text.trim().isNotEmpty) {
                                if (editingIndex != null) {
                                  /*
          
                                  ...Before SQFlite...
          
                                  todolist[editingIndex!] = TaskData(
                                      tasktitle: title.text.trim(),
                                      taskdesc: desc.text.trim(),
                                      taskdate: date.text.trim());
          
                                  */
          
                                  updatetask(TaskData(
                                    taskid: todolist[editingIndex!].taskid,
                                    tasktitle: title.text.trim(),
                                    taskdesc: desc.text.trim(),
                                    taskdate: date.text.trim(),
                                  ));
          
                                  title.clear();
                                  desc.clear();
                                  date.clear();
          
                                  setState(() {});
                                  editingIndex = null;
                                } else {
                                  /*
          
                                  Before SQFlite
          
                                  ToDOListAppModel addobj = ToDOListAppModel(
                                      titleController: title.text.trim(),
                                      descriptionController: desc.text.trim(),
                                      dateController: date.text);
          
                                  */
          
                                  TaskData newtask = TaskData(
                                      tasktitle: title.text.trim(),
                                      taskdesc: desc.text.trim(),
                                      taskdate: date.text.trim());
          
                                  // insert data in database
          
                                  if (title.text.trim().isNotEmpty &&
                                      desc.text.trim().isNotEmpty &&
                                      date.text.trim().isNotEmpty) {
                                    inserttaskdata(newtask);
                                    isTaskAvailable = true;
          
                                    /*
                                        ...Before SQFlite...
          
                                        todolist.add(addobj);
          
                                      */
                                  }
                                }
                              }
                              setState(() {});
          
                              title.clear();
                              desc.clear();
                              date.clear();
          
                              Navigator.pop(context);
                            }
                          },
                          child: const Text(
                            "Add Task",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getTaskData(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            todolist = snapshot.data!;

            return Scaffold(
              backgroundColor: const Color.fromRGBO(111, 81, 255, 1),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, top: 100, bottom: 10),
                    child: Text(
                      "Good morning",
                      style: GoogleFonts.quicksand(
                        textStyle: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(255, 255, 255, 1)),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 50, bottom: 50),
                    child: Text(
                      "Ganesh",
                      style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(255, 255, 255, 1))),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(217, 217, 217, 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: Text(
                              "CREATE TO DO LIST",
                              style: GoogleFonts.quicksand(
                                  textStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(0, 0, 0, 1))),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(top: 20),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40)),
                                color: Color.fromRGBO(255, 255, 255, 1),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [

                                    Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          topRight: Radius.circular(40),
                                        ),
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                      ),
                                      child: todolist.isNotEmpty
                                          ? ListView.builder(
                                              physics: const ScrollPhysics(),
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: todolist.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 20,
                                                          right: 20,
                                                          left: 20),
                                                  child: Slidable(
                                                    endActionPane: ActionPane(
                                                      motion:
                                                          const ScrollMotion(),
                                                      children: [
                                                        SlidableAction(
                                                          onPressed: (context) {
                                                            editingIndex =
                                                                index;
                                                            title.text =
                                                                todolist[index]
                                                                    .tasktitle;
                                                            desc.text =
                                                                todolist[index]
                                                                    .taskdesc;

                                                            date.text =
                                                                todolist[index]
                                                                    .taskdate;

                                                            BottomSheetPage();
                                                          },
                                                          backgroundColor:
                                                              const Color(
                                                                  0xFF0392CF),
                                                          foregroundColor:
                                                              const Color
                                                                  .fromARGB(255,
                                                                  17, 7, 7),
                                                          icon: Icons.edit,
                                                        ),
                                                        SlidableAction(
                                                          onPressed: (context) {
                                                            deletetaskdata(
                                                                todolist[index]
                                                                    .taskid!);
                                                            setState(() {
                                                              /*
                                                              ...Before SQFlite...

                                                              todolist.removeAt(
                                                               index);
                                                               
                                                              */
                                                            });
                                                            title.clear();
                                                            desc.clear();
                                                            date.clear();
                                                          },
                                                          backgroundColor:
                                                              const Color(
                                                                  0xFF0392CF),
                                                          foregroundColor:
                                                              const Color
                                                                  .fromARGB(255,
                                                                  17, 7, 7),
                                                          icon: Icons.delete,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              bottom: 10),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: const Color
                                                              .fromRGBO(
                                                            0,
                                                            0,
                                                            0,
                                                            0.15,
                                                          )),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            height: 52,
                                                            width: 52,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40),
                                                              color: const Color
                                                                  .fromRGBO(230,
                                                                  239, 239, 1),
                                                            ),
                                                            child: Image.asset(
                                                                "assets/images/adto2.png"),
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  todolist[
                                                                          index]
                                                                      .tasktitle,
                                                                  style:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    textStyle: const TextStyle(
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            1),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            17),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  todolist[
                                                                          index]
                                                                      .taskdesc,
                                                                  style:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    textStyle: const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        color: Color.fromRGBO(
                                                                            143,
                                                                            143,
                                                                            143,
                                                                            1)),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  todolist[
                                                                          index]
                                                                      .taskdate,
                                                                  style: GoogleFonts.inter(
                                                                      textStyle: const TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.w400)),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              })
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 50,
                                                ),
                                                Center(
                                                    child: Image.asset(
                                                        'assets/images/todo2.png')),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Center(
                                                  child: Text(
                                                    'Add Your First Task',
                                                    style: GoogleFonts.lato(
                                                        textStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .displayLarge,
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        color: const Color
                                                            .fromARGB(
                                                            186, 35, 29, 29)),
                                                  ),
                                                ),
                                                Center(
                                                    child: Text(
                                                        'Click On + To Add Task',
                                                        style: GoogleFonts
                                                            .quicksand(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)))
                                              ],
                                            ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    flag = false;
                    flag1 = false;
                    flag2 = false;
                  });

                  isTaskAvailable = true;
                  editingIndex = null;
                  title.clear();
                  desc.clear();
                  date.clear();
                  BottomSheetPage();
                },
                child: const Text(
                  '+',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  void textvalidation() {
    if (title.text.isEmpty && desc.text.isEmpty && date.text.isEmpty) {
      flag = true;
      flag1 = true;
      flag2 = true;
    }

    if (title.text.isNotEmpty && (desc.text.isEmpty && date.text.isEmpty)) {
      flag = false;
      flag1 = true;
      flag2 = true;
    }

    if (desc.text.isNotEmpty && (title.text.isEmpty && date.text.isEmpty)) {
      flag = false;
      flag1 = true;
      flag2 = true;
    }

    if (date.text.isNotEmpty && (desc.text.isEmpty && title.text.isEmpty)) {
      flag = false;
      flag1 = true;
      flag2 = true;
    }
  }
}
