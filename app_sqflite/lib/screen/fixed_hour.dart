
import 'package:app_sqflite/sqflite/db.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:intl/intl.dart';

import '../component/func.dart';
import '../component/shared_prefernces.dart';
import '../component/theme.dart';
import '../component/widget.dart';
import 'about_hour.dart';


class FixedHourScreen extends StatefulWidget {
  const FixedHourScreen({Key? key}) : super(key: key);

  @override
  State<FixedHourScreen> createState() => _FixedHourScreenState();
}

class _FixedHourScreenState extends State<FixedHourScreen> {

  String currentDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  List listFixedHour = [];
  String dropdownvalue = 'السبت';

  // List of items in our dropdown menu
  var items = [
    'السبت',
    'الأحد',
    'الإثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
  ];


@override
  void initState() {
    // TODO: implement initState
  currentDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  dropdownvalue = 'السبت';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality
      (
        textDirection: ui.TextDirection.rtl,
        child:Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("الساعات المحجوزة ثابت",style: headingStyle(color: Colors.white, fontSize: 22),),
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade300, //Colors.green.shade600,
                      border: Border.all(
                          width: 3.0, color: Colors.indigo.shade700),
                      borderRadius: const BorderRadius.all(Radius.circular(
                        15.0,
                      ) //
                      ),
                    ),
                    child: Center(
                      child: DropdownButton(
                        dropdownColor: Colors.teal.shade300,
                        value: dropdownvalue,
                        elevation: 0,
                        icon: const Icon(Icons.keyboard_arrow_down,color: Colors.indigo,),
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items,style: headingStyle(color: Colors.white, fontSize: 18),),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: FutureBuilder(
                  future: allFixedHour(day: dropdownvalue),
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
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, i) {
                          return buildContainer(
                            index: i,
                              data: data
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
            ],
          )
        )
    );
  }

  buildContainer({
    required int index,
    required List data,
  })
  {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        //height: 520,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.teal.shade600, //Colors.green.shade600,
          border: Border.all(
              width: 3.0,
              color: Colors.indigo.shade700
          ),
          borderRadius: const BorderRadius.all(
              Radius.circular(20.0,) //
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  radius: 26,
                  child: Text((index+1).toString(),style: headingStyle(color: Colors.white, fontSize: 16),),
                ),
                const SizedBox(width: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: buildIcon(icon: Icons.person, color: Colors.white),
                      ),
                      Text(data[index].name,style: headingStyle(color: Colors.white, fontSize: 20),),
                    ],),
                    Row(children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: buildIcon(icon: Icons.access_time, color: Colors.white),
                      ),
                      Text("${data[index].hour}  ${data[index].type}",style: headingStyle(color: Colors.white, fontSize: 20),),
                    ],),
                    InkWell(
                      onTap: (){
                        setState(() {
                          makePhoneCall(phoneNumber:data[0].phone );
                        });
                      },
                      child: Row(children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: buildIcon(icon: Icons.phone_android, color: Colors.white),
                        ),
                        Text(data[index].phone,style: headingStyle(color: Colors.white, fontSize: 20),),
                      ],),
                    )

                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

