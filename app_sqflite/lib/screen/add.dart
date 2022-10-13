import 'dart:ui' as ui;
import 'package:app_sqflite/screen/ava_hour.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../component/func.dart';
import '../component/shared_prefernces.dart';
import '../component/theme.dart';
import '../component/widget.dart';
import '../model/faw_model.dart';
import '../sqflite/db.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  var formKey = GlobalKey <FormState>();
  late int id;

  String currentDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerNotes = TextEditingController();
  late String myName;
  late String myPhone;
  late String myNotes;
  late String myHour;
  late String myType;
  late String myDate;
  late String myDay;
  bool weekly = false;
  bool money = false;
  @override
  void initState() {
    // TODO: implement initState
     myHour = SharedClass.getString(key: "hour");
     myType = SharedClass.getString(key: "type");
     myDate = SharedClass.getString(key: "date");
     myDay = SharedClass.getString(key: "day");
    weekly = false;
    money = false;
    super.initState();

  }
  Widget build(BuildContext context) {
    void validateAndSave()async {
      final FormState? form = formKey.currentState;
      if (form!.validate())
      {
        form.save();
        int id = await maxID() >=0?await maxID() : 0;
        setState(() {
          print(id);
          var hour =  Faw(
              id: ++id,
              name: controllerName.text,
              phone:controllerPhone.text,
              date: myDate,
              day: myDay,
              hour: myHour,
              type: myType,
              notes: controllerNotes.text,
              money: money.toString(),
              weekly:weekly.toString()
          );
          setState(() {
            insertHour(hour,context).then((value){
              print(hour);

            });
          });
          //
          setState(() {
          });
          print('Form is valid');
        });
        }
        //showToast(context: context, msg: "good", color: Colors.green);
      else {
        //showToast(context: context, msg: "Not good", color: Colors.red);
      }
    }

    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("حجز ساعة ",style: headingStyle(
            fontSize: 20,
            color: Colors.white
          ),),
          //centerTitle: true,
        ),
        body:
        SingleChildScrollView(
        child: Form(
        key: formKey,
        child: Directionality(
          textDirection: ui.TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              buildTextFormFieldToReadOly(
                text:"الساعة",
                iconPre: Icons.lock_clock,
                controller: TextEditingController(text: "$myHour  $myType" ),
              ),
              buildTextFormFieldToReadOly(
                text:"اليوم",
                iconPre: Icons.date_range,
                  controller: TextEditingController(text: "$myDay  $myDate  "),
              ),

//---------------------------------------------------------------------------
              buildTextFormField(
                controller: controllerName,
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

              buildTextFormField(
                  controller: controllerPhone,
                  text: "الهاتف",
                  textInputType: TextInputType.phone,
                  iconPre: Icons.phone_android,
                  validate:(value)
                  {
                    if (value == null || value.isEmpty||value.length!=11) {
                      return "أدخل رقم صالحاً من فضلك";
                    }
                    return null;
                  },
                  onSaved: (val){
                    myPhone = val;
                  }
              ),
              buildTextFormField(
                  controller: controllerNotes,
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

              buildCheckBox(
                text: "الحجز الأسبوعى",
                value: weekly,
                onChanged: (val)
                  {
                    setState(() {
                      weekly = val;
                    });
                  }
              ),

              Center(
                child: Padding(padding: const EdgeInsets.all(20),
                  child:  buildMaterialButton(
                      text: "حجز الساعة" ,
                      color: Colors.teal,
                      function:validateAndSave,
                  ),
                ),
              )
            ],
          ),
        ),
      )
      ),
      ),
    );
  }
}
