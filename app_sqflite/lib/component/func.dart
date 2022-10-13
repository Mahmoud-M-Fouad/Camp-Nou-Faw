import 'package:app_sqflite/component/theme.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';


gatDay(
    {
      required  String currentDate,
    })
{
  String day;
  var date = DateTime.parse(currentDate);
  if(DateFormat('EEEE').format(date)=="Saturday")
  {
    day ="السبت";
  }
  else if(DateFormat('EEEE').format(date)=="Sunday")
  {
    day ="الأحد";
  }
  else if(DateFormat('EEEE').format(date)=="Monday")
  {
    day ="الإثنين";
  }
  else if(DateFormat('EEEE').format(date)=="Tuesday")
  {
    day ="الثلاثاء";
  }
  else if(DateFormat('EEEE').format(date)=="Wednesday")
  {
    day ="الأربعاء";
  }
  else if(DateFormat('EEEE').format(date)=="Thursday")
  {
    day ="الخميس";
  }
  else if(DateFormat('EEEE').format(date)=="Friday")
  {
    day ="الجمعة";
  }
  else
  {
    day ="";
  }
  return day;
}


showAweSomeDialogYes({
  required BuildContext context,
  required DialogType dialogType,
  required String body,
  required Color colorBorder,
  required var funOk,
})

{
  return AwesomeDialog(
    context: context,
    dialogType: dialogType,
    borderSide:  BorderSide(

      color: colorBorder,
      width: 2,
    ),
    width: 500,
    buttonsBorderRadius: const BorderRadius.all(

      Radius.circular(2),
    ),
    dismissOnTouchOutside: true,
    dismissOnBackKeyPress: false,
    headerAnimationLoop: true,
    animType: AnimType.bottomSlide,
    body:Text(body,style: headingStyle(color: Colors.black, fontSize: 18),),
    btnOkOnPress: funOk,
    btnOkText: "تم",
  ).show();
}

showAweSomeDialog({
  required BuildContext context,
  required DialogType dialogType,
  required String body,
  required Color colorBorder,
  required var funCancel,
  required var funOk,
})

{
  return AwesomeDialog(
      context: context,
      dialogType: dialogType,
      borderSide:  BorderSide(

        color: colorBorder,
        width: 2,
      ),
      width: 500,
      buttonsBorderRadius: const BorderRadius.all(

        Radius.circular(2),
      ),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: true,
      animType: AnimType.bottomSlide,
      body:Text(body,style: headingStyle(color: Colors.black, fontSize: 18),),
      btnCancelOnPress: funCancel,
      btnOkOnPress: funOk,
      btnOkText: "نعم",
      btnCancelText: "لا"
  ).show();
}

navigatorToEnd(
    {
      required BuildContext context,
      required var screen,
    })
{
  return Navigator.pushAndRemoveUntil<dynamic>(
    context,
    MaterialPageRoute<dynamic>(
      builder: (BuildContext context) => screen,
    ),
        (route) => false,//if you want to disable back feature set to false
  );
}
navigatorTo(
    {
      required BuildContext context,
      required var screen,
    })
{
  return Navigator.push(
    context ,
    MaterialPageRoute(builder: (context) =>screen),
  );
}

showToast({
  required BuildContext context,
  required String msg,
  required Color color,
}) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 1),
      content: Text(msg, style:  TextStyle(color: color,fontSize: 18),textAlign: TextAlign.right,),
    ),
  );
}


showDialogMethod({
  required BuildContext context ,
  required Widget title ,
  required Widget content ,
  required Function cancelButton ,
  required String textCancel ,
  required var continueButton  ,
  required String textContinue
})
{
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return  AlertDialog(
        backgroundColor: Colors.deepPurple.shade100,
        titleTextStyle: headingStyle(color: Colors.indigo, fontSize: 20),
        contentTextStyle: headingStyle(color: Colors.indigo.shade300, fontSize: 16),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),

        title: title,
        titlePadding: const EdgeInsets.all(10),
        content: content,
        actions: [
          TextButton(onPressed:()
          {
            Navigator.pop(context);
          }
            , child: Text(textCancel,textAlign: TextAlign.end,
                style:TextStyle(fontSize: 20,color: Colors.red.shade700) ),),

          TextButton(onPressed:continueButton, child: Text(textContinue ,textAlign: TextAlign.start,
              style:TextStyle(fontSize: 20,color: Colors.green.shade500)
          ))
        ],
      );
    },
  );
}

Future<void> makePhoneCall({required String phoneNumber}) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}



buildImageProfile({
  required double radius ,
  required String imagePath ,
} )
{
  return Padding(
    padding: const EdgeInsets.all(10),
    child: CircleAvatar(
      backgroundImage: AssetImage(imagePath),
      radius: radius,
    ),
  );
}
buildCopy({
  required String textCopy ,required BuildContext context
})
{
  FlutterClipboard.copy(textCopy).then(( value ) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 1),
        content: Text('تم النسخ' , style: TextStyle(color: Colors.green,fontSize: 18),textAlign: TextAlign.right,),
      ),
    );
  });
}

buildPast({
  required String textCopy ,required String pasteValue
})
{
  FlutterClipboard.paste().then((value) {
    textCopy = value;
    pasteValue = value;
  });

}
