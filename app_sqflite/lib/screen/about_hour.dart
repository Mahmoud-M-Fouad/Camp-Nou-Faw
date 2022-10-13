import 'package:app_sqflite/screen/all_hour.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../component/func.dart';
import '../component/shared_prefernces.dart';
import '../component/theme.dart';
import '../component/widget.dart';
import 'dart:ui' as ui;

import '../sqflite/db.dart';
class AboutHour extends StatefulWidget {
  const AboutHour({Key? key}) : super(key: key);

  @override
  State<AboutHour> createState() => _AboutHourState();
}

class _AboutHourState extends State<AboutHour> {
  //var data;
  String myName = "";
  String myWeekly = "";
  String myMoney = "";
  String myNotes = "";
  /*
  getData()
  {
     hourWithId(
        id:SharedClass.getInt(key: "ID")
    ).then((value){
      data  = value;
    });
  }
  */
  @override
  void initState() {
    // TODO: implement initState
    //getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var data ;
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title:Text("بيانات الحجز",style: headingStyle(color: Colors.white, fontSize: 22),),
          centerTitle: true,
          elevation: 0,
          //backgroundColor: Colors.white,
          actions: [
            buildIconButton(icon: Icons.phone, color: Colors.yellow,
                onPressed: (){
              setState(() {
                makePhoneCall(phoneNumber:data[0].phone );
              });
                }
            ),
          ],
        ),
        body: FutureBuilder(
          future: hourWithId(
              id:SharedClass.getInt(key: "ID")
          ),
          builder: (ctx, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occurred',
                  style: const TextStyle(fontSize: 18),
                ),
              );
            } else if (snapshot.hasData) {
               data = snapshot.data as List;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*const Divider(height: 20,color: Colors.transparent,),
              SizedBox(
                height: 150,
                child: Lottie.asset('assets/player.json',fit: BoxFit.cover,height: 100),
              ),*/
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    buildIcon(icon: Icons.person, color: Colors.black,
                                    ),
                                    const SizedBox(width: 10,),
                                    Text("الأسم",style: headingStyle(color: Colors.black, fontSize: 20),),
                                  ],
                                ),
                                buildIconButton(icon: Icons.update, color: Colors.teal,onPressed: (){
                                  setState(() {
                                    showDialogMethod(
                                        context: context,
                                        title: Text("تعديل الأسم",style: headingStyle(color: Colors.black, fontSize: 20),textAlign: TextAlign.center),
                                        content: Directionality(
                                          textDirection: ui.TextDirection.rtl,
                                          child: buildTextFormField(
                                              controller: TextEditingController(text: data[0].name),
                                              text: "الأسم",
                                              textInputType: TextInputType.name,
                                              iconPre: Icons.person,
                                              validate:(value)
                                              {
                                                if (value == null || value.isEmpty) {
                                                  return "أدخل الأسم من فضلك";
                                                }
                                                if (value.length>30) {
                                                  return "أدخل أسم صغير من فضلك";
                                                }
                                                return null;
                                              },
                                              onSaved: (val){
                                                myName = val;
                                              }
                                          ),
                                        ),
                                        cancelButton: (){},
                                        continueButton: (){
                                          setState(() {
                                            if(myName.isNotEmpty)
                                              {
                                                updateName(
                                                    name: myName,
                                                    id: SharedClass.getInt(key: "ID"),
                                                    context: context
                                                ).then((value) {

                                                });
                                                //Future.delayed(const Duration(seconds: 2));
                                                Navigator.pop(context);
                                              }
                                            else
                                            {
                                              updateName(
                                                  name: data[0].name,
                                                  id: SharedClass.getInt(key: "ID"),
                                                  context: context
                                              );
                                              //Future.delayed(const Duration(seconds: 2));
                                              Navigator.pop(context);
                                            }
                                          });
                                        },
                                        textContinue: "تأكيد",
                                        textCancel: "رجوع"

                                    );

                                    //-------------
                                    /* updateName(
                              name: name,
                              id: SharedClass.getInt(key: "ID"),
                              context: context
                          )*/
                                  });
                                }),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(data[0].name,style: headingStyle(color: Colors.green, fontSize: 20),),
                              ],),
                          ],),
                        const Divider(height: 10,color: Colors.teal,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                buildIcon(icon: Icons.date_range_outlined, color: Colors.black,
                                ),
                                const SizedBox(width: 10,),
                                Text("التاريخ",style: headingStyle(color: Colors.black, fontSize: 20),),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(data[0].date,style: headingStyle(color: Colors.green, fontSize: 20),),
                              ],),
                          ],),
                        const Divider(height: 20,color: Colors.transparent,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Divider(height: 10,color: Colors.teal,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    buildIcon(icon: Icons.timer_outlined, color: Colors.black,
                                    ),
                                    const SizedBox(width: 10,),
                                    Text("موعد الحجز",style: headingStyle(color: Colors.black, fontSize: 20),),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(data[0].day+"  ",style: headingStyle(color: Colors.green, fontSize: 20),),
                                    Text(data[0].hour+" ",style: headingStyle(color: Colors.green, fontSize: 20),),
                                    Text(data[0].type+"  ",style: headingStyle(color: Colors.green, fontSize: 20),),

                                  ],),
                              ],),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Divider(height: 10,color: Colors.teal,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        buildIcon(icon: Icons.gps_fixed_outlined, color: Colors.black,
                                        ),
                                        const SizedBox(width: 10,),
                                        Text("الحجز الأسبوعى ",style: headingStyle(color: Colors.black, fontSize: 20),),
                                      ],
                                    ),
                                    buildIconButton(icon: Icons.change_circle, color: Colors.teal,onPressed: (){
                                      setState(() {
                                        showAweSomeDialog(
                                            context: context,
                                            dialogType: DialogType.question,
                                            body: "هل تريد تعدبل الحجز الأسبوعى",
                                            colorBorder: Colors.green,
                                            funCancel: (){},
                                            funOk: (){
                                              setState(() {
                                                data[0].weekly=="true"?
                                                myWeekly = "false":
                                                myWeekly = "true";
                                                updateWeekly(weekly: myWeekly,
                                                    id: SharedClass.getInt(key: "ID"),
                                                    context: context
                                                ).then((value){
                                                });
                                              });
                                            }
                                        );
                                      });
                                    }),
                                  ],
                                ),
                                const SizedBox(width: 10,),
                                data[0].weekly=="true"?
                                Text("ساعة ثابتة",style: headingStyle(color: Colors.green, fontSize: 20),):
                                Text("ليس ساعة ثابتة",style: headingStyle(color: Colors.green, fontSize: 20),),
                              ],),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Divider(height: 10,color: Colors.teal,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        buildIcon(icon: Icons.monetization_on_outlined, color: Colors.black,
                                        ),
                                        const SizedBox(width: 10,),
                                        Text("فلوس الحجز ",style: headingStyle(color: Colors.black, fontSize: 20),),
                                      ],
                                    ),
                                    buildIconButton(icon: Icons.change_circle, color: Colors.teal,onPressed: (){
                                      showAweSomeDialog(
                                          context: context,
                                          dialogType: DialogType.question,
                                          body: "هل تريد تعدبل فلوس الأسبوعى",
                                          colorBorder: Colors.green,
                                          funCancel: (){},
                                          funOk: (){
                                            setState(() {
                                              data[0].money=="true"?
                                              myMoney = "false":
                                              myMoney = "true";
                                              updateMoney(money: myMoney,
                                                  id: SharedClass.getInt(key: "ID"),
                                                  context: context
                                              ).then((value) {
                                              });
                                            });
                                          }
                                      );
                                    }),
                                  ],
                                ),
                                const SizedBox(width: 10,),
                                data[0].money=="true"?
                                Text("تم دفع فلوس الحجز",style: headingStyle(color: Colors.green, fontSize: 20),):
                                Text("فلوس الحجز ليس مدفوعة",style: headingStyle(color: Colors.green, fontSize: 20),),

                              ],),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Divider(height: 10,color: Colors.teal,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        buildIcon(icon: Icons.note_alt_outlined, color: Colors.black,
                                        ),
                                        const SizedBox(width: 10,),
                                        Text("الملاحظات ",style: headingStyle(color: Colors.black, fontSize: 20),),
                                      ],
                                    ),
                                    buildIconButton(icon: Icons.update, color: Colors.teal,onPressed: (){
                                      setState(() {
                                        showDialogMethod(
                                            context: context,
                                            title: Text("تعديل الملاحظات",style: headingStyle(color: Colors.black, fontSize: 20),textAlign: TextAlign.center),
                                            content: Directionality(
                                              textDirection: ui.TextDirection.rtl,
                                              child:buildTextFormField(
                                                  controller: TextEditingController(text:data[0].notes ),
                                                  text: "الملاحظات",
                                                  textInputType: TextInputType.text,
                                                  iconPre: Icons.note_alt_sharp,
                                                  validate:(value)
                                                  {
                                                    if (value.length>100) {
                                                      return "أدخل الملاحظات صالحاً من فضلك ،الملاحظات كبيرة للغاية";
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (val){
                                                    myNotes = val;
                                                  }
                                              ),
                                            ),
                                            cancelButton: (){},
                                            continueButton: (){
                                              setState(() {
                                                updateNotes(notes: myNotes,
                                                    id: SharedClass.getInt(key: "ID"),
                                                    context: context).then((value){
                                                });
                                                //Future.delayed(const Duration(seconds: 2));
                                                Navigator.pop(context);
                                              });
                                              setState(() {

                                              });
                                            },
                                            textContinue: "تأكيد",
                                            textCancel: "رجوع"

                                        );

                                        //-------------

                                      });
                                    }),
                                  ],
                                ),
                                const SizedBox(width: 10,),
                                data[0].notes.isEmpty?
                                Text("لا يوجد ملاحظات",style: headingStyle(color: Colors.green, fontSize: 20),):
                                Text(data[0].notes,style: headingStyle(color: Colors.green, fontSize: 20),),
                                const Divider(height: 10,color: Colors.teal,),
                              ],),
                          ],
                        )
                      ],
                    ),
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
    );
  }
}
