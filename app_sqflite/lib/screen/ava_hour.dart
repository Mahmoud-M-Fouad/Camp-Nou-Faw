import 'package:app_sqflite/sqflite/db.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../component/func.dart';
import '../component/shared_prefernces.dart';
import '../component/theme.dart';
import '../component/widget.dart';
import 'add.dart';
import 'dart:ui' as ui;

class AvaHourScreen extends StatefulWidget {
  const AvaHourScreen({Key? key}) : super(key: key);

  @override
  State<AvaHourScreen> createState() => _AvaHourScreenState();
}

class _AvaHourScreenState extends State<AvaHourScreen> {
  String currentDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  List listAm = [];
  List listPm = [];
  /*
  resHours()async
  {
    listAm = await allHourAm(currentDate);
    listPm = await allHourPm(currentDate);
  }*/

  @override
  void initState() {
    currentDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
     listAm = [];
     listPm = [];
   // resHours();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.parse(currentDate),
          firstDate: DateTime.now(),
          lastDate: DateTime(2050));
      if (pickedDate != null && pickedDate != DateTime.parse(currentDate)) {
        setState(() {
          currentDate = DateFormat("yyyy-MM-dd").format(pickedDate);

          print(currentDate);
        });
      }
      return currentDate;
    }
    listAm = [];
    listPm = [];

    return Directionality(
        textDirection: ui.TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "الساعات المتاحة",
                style: headingStyle(color: Colors.white, fontSize: 22),
              ),
              centerTitle: true,
            ),
            body:
            Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade400, //Colors.green.shade600,
                        border: Border.all(
                            width: 3.0, color: Colors.indigo.shade700),
                        borderRadius: const BorderRadius.all(Radius.circular(
                          15.0,
                        ) //
                            ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildIconButton(
                              icon: Icons.date_range_outlined,
                              color: Colors.indigo,
                              onPressed: () {
                                selectDate(context).then((value) {
                                  setState(() {
                                  });
                                });
                              }),
                          Text(
                            gatDay(currentDate: currentDate),
                            style:
                                headingStyle(color: Colors.white, fontSize: 22),
                          ),
                          Text(
                            currentDate,
                            style:
                                headingStyle(color: Colors.white, fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Row(
                    children: [
                      Expanded(
                        /*child: FutureBuilder(
                          future: getReHour(date: currentDate),
                          builder: (context,i)
                          {
                            return ListView.builder(
                              itemCount: 6,
                              itemBuilder: (context, i) {
                                return buildContainerHours(
                                    hour: (i + 1).toString(),
                                    i: i + 1,
                                    color: listAm.contains((i + 1).toString())
                                        ? Colors.red
                                        : Colors.green,
                                    type: "صباحاً");
                              },
                            );
                          },
                        ),*/
                        child: FutureBuilder(
                          future: allHourAm(currentDate),
                          builder: (ctx, snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(
                                    '${snapshot.error} occurred',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                );
                              } else if (snapshot.hasData) {
                                var data = snapshot.data as List;
                                listAm =data;
                                return ListView.builder(
                                  itemCount: 6,
                                  itemBuilder: (context, i) {
                                    return buildContainerHours(
                                        hour: (i + 1).toString(),
                                        i: i + 1,
                                        color: data.contains((i + 1).toString())
                                            ? Colors.red
                                            : Colors.green,
                                        type: "صباحاً"
                                    );
                                  },
                                );
                            }
                              // Displaying LoadingSpinner to indicate waiting state
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },

                        ),
                      ),
                      Expanded(
                        child: FutureBuilder(
                          future: allHourAm(currentDate),
                            builder: (ctx, snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text(
                                      '${snapshot.error} occurred',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  );
                                } else if (snapshot.hasData) {
                                  var data = snapshot.data as List;
                                  listAm =data;
                                  return ListView.builder(
                                    itemCount: 6,
                                    itemBuilder: (context, i) {
                                      return buildContainerHours(
                                          hour: (i + 7).toString(),
                                          i: i + 7,
                                          color: data.contains((i + 7).toString())
                                              ? Colors.red
                                              : Colors.green,
                                          type: "صباحاً");
                                    },
                                  );
                                }
                              // Displaying LoadingSpinner to indicate waiting state
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                        ),
                      ),

                      // const SizedBox(width: 10,),
                      Expanded(
                        /*child: FutureBuilder(
                          future: getReHour(date: currentDate),
                          builder: (context,i)
                          {
                            return ListView.builder(
                              itemCount: 6,
                              itemBuilder: (context, i) {
                                return buildContainerHours(
                                    hour: (i + 1).toString(),
                                    i: i + 1,
                                    color: listAm.contains((i + 1).toString())
                                        ? Colors.red
                                        : Colors.green,
                                    type: "صباحاً");
                              },
                            );
                          },
                        ),*/
                        child: FutureBuilder(
                          future: allHourPm(currentDate ),
                            builder: (ctx, snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text(
                                      '${snapshot.error} occurred',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  );
                                } else if (snapshot.hasData) {
                                  var data = snapshot.data as List;
                                  listPm =data;
                                  return ListView.builder(
                                    itemCount: 6,
                                    itemBuilder: (context, i) {
                                      return buildContainerHours(
                                          hour: (i + 1).toString(),
                                          i: i + 1,
                                          color: data.contains((i + 1).toString())
                                              ? Colors.red
                                              : Colors.green,
                                          type: "مساءاً");
                                    },
                                  );
                                }

                              // Displaying LoadingSpinner to indicate waiting state
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },

                        ),
                      ),
                      Expanded(
                        child: FutureBuilder(
                          future: allHourPm(currentDate),
                            builder: (ctx, snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text(
                                      '${snapshot.error} occurred',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  );
                                } else if (snapshot.hasData) {
                                  var data = snapshot.data as List;
                                  listPm =data;
                                  return ListView.builder(
                                    itemCount: 6,
                                    itemBuilder: (context, i) {
                                      return buildContainerHours(
                                          hour: (i + 7).toString(),
                                          i: i + 7,
                                          color: data.contains((i + 7).toString())
                                              ? Colors.red
                                              : Colors.green,
                                          type: "مساءاً");
                                    },
                                  );
                              }

                              // Displaying LoadingSpinner to indicate waiting state
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )

        ));
  }

  buildContainerHours({
    required String hour,
    required String type,
    required Color color,
    required int i,
  }) {
    return InkWell(
      onTap: () {
        if (listAm.contains((i).toString()) && type == "صباحاً") {
          showAweSomeDialogYes(
              context: context,
              dialogType: DialogType.error,
              colorBorder: Colors.red.shade900,
              body: "هذه الساعة محجوزة من قبل",
              funOk: () {});
        } else if (listPm.contains((i).toString()) && type == "مساءاً") {
          showAweSomeDialogYes(
              context: context,
              dialogType: DialogType.error,
              colorBorder: Colors.red.shade900,
              body: "هذه الساعة محجوزة من قبل",
              funOk: () {});
        } else {
          SharedClass.setString(key: "hour", str: hour);
          SharedClass.setString(key: "type", str: type);
          SharedClass.setString(key: "date", str: currentDate);
          SharedClass.setString(
              key: "day", str: gatDay(currentDate: currentDate));
          navigatorTo(context: context, screen: const AddScreen());
        }
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8.0),
        decoration: myBoxDecoration(color: color),
        child: Text(
          "$hour $type",
          style: headingStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }
}
