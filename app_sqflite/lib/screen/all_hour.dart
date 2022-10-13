
import 'package:app_sqflite/screen/about_hour.dart';
import 'package:app_sqflite/sqflite/db.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;
import '../component/func.dart';
import '../component/shared_prefernces.dart';
import '../component/theme.dart';
import '../component/widget.dart';


class AllHourScreen extends StatefulWidget {
  const AllHourScreen({Key? key}) : super(key: key);

  @override
  State<AllHourScreen> createState() => _AllHourScreenState();
}

class _AllHourScreenState extends State<AllHourScreen> {
  String currentDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

  @override
  void initState() {
    // TODO: implement initState
    resWeekly();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.parse(currentDate),
          firstDate: DateTime(DateTime.now().year - 1),
          lastDate: DateTime(2050));
      if (pickedDate != null && pickedDate != DateTime.parse(currentDate)) {
        setState(() {
          currentDate = DateFormat("yyyy-MM-dd").format(pickedDate);
          print(currentDate);
        });
      }
      return currentDate;
    }

    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("عرض الساعات المحجوزة",style: headingStyle(color: Colors.white, fontSize: 20),),
          centerTitle: true,
        ),
        body:Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildIconButton(
                          icon: Icons.date_range_outlined,
                          color: Colors.indigo,
                          onPressed: () {
                            setState(() {
                              selectDate(context).then((value) {
                                allHour(date: value);
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
              child : FutureBuilder(
                future: allHour(date: currentDate),
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
                        return buildContainer(index: i,data: data);                },
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
      ),
    );
  }


  buildContainer({
    required int index,
    required List data
})
  {
   return Padding(
     padding: const EdgeInsets.all(8.0),
     child: InkWell(
       onTap: ()
       {
         SharedClass.setInt(key: "ID", num: (data[index].id));
         navigatorTo(context: context, screen: const AboutHour());
       },
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
                   backgroundColor: Colors.deepPurple.shade400,
                   radius: 26,
                   child: Text((index+1).toString(),style: headingStyle(color: Colors.white, fontSize: 16),),
                 ),
                 const SizedBox(width: 10,),
                 Column(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       //crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                       CircleAvatar(
                         backgroundColor: Colors.transparent,
                         child: buildIcon(icon: Icons.person, color: Colors.white),
                       ),
                       Text(data[index].name,style: headingStyle(color: Colors.white, fontSize: 20),),

                     ],),
                     Row(
                       children: [
                       CircleAvatar(
                         backgroundColor: Colors.transparent,
                         child: buildIcon(icon: Icons.access_time, color: Colors.white),
                       ),
                       Text("${data[index].hour}  ${data[index].type}",style: headingStyle(color: Colors.white, fontSize: 20),),
                     ],),
                     Row(children: [
                       CircleAvatar(
                         backgroundColor: Colors.transparent,
                         child: buildIcon(icon: Icons.phone_android, color: Colors.white),
                       ),
                       Text("${data[index].phone}",style: headingStyle(color: Colors.white, fontSize: 20),),
                     ],)

                   ],
                 ),
                 Expanded(
                   flex: 1,
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       buildIconButton(icon: Icons.delete_forever, color: Colors.red, onPressed: (){
                              setState(() {
                                showAweSomeDialog(
                                    context: context,
                                    dialogType: DialogType.question,
                                    body: "هل تريد حذف هذه الساعة",
                                    colorBorder: Colors.deepPurple,
                                    funCancel: (){},
                                    funOk: (){
                                      setState(() {
                                        deleteHour(data[index].id,context);    
                                      });
                                    }
                                );
                              });
                       })
                     ],),
                 ),
               ],
             ),
           ],
         ),
       ),
     ),
   );
  }

}
