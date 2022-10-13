import 'package:app_sqflite/component/theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Camp Nou Faw",style: headingStyle(color: Colors.white, fontSize: 20),),
            elevation: 0,
          ),
          body: Center(
            child: Column(
              children: [
                const SizedBox(height:10 ,),
                Text("ملعب فاو",style: headingStyle(color: Colors.teal, fontSize: 18),),
                Expanded(
                  child: Lottie.asset('assets/42712-football-stadium.json'),
                ),
                Expanded(
                    child: Column(
                      children: [
                        Text("تطبيق حجز ساعات الكورة",style: headingStyle(color: Colors.teal, fontSize: 18),),
                        Text("من خلال التطبيق  ",style: headingStyle(color: Colors.black, fontSize: 16),),
                        Text("1. تسطتيع تسجيل الساعات اليومية الثابتة والغير ثابتة",style: headingStyle(color: Colors.black, fontSize: 14),),
                        Text("2. تسطتيع تعديل أو حذف ساعة محجوزة من قبل",style: headingStyle(color: Colors.black, fontSize: 14),),
                        Text("3. امكانة تحديد لكل ساعة محجوزة إستلمت منها فلوس الحجز ام لا",style: headingStyle(color: Colors.black, fontSize: 14) ,),
                        Text("4. امكانة تحويل الساعة الثابتة لغير ثابتة والعكس",style: headingStyle(color: Colors.black, fontSize: 14) ,),
                        const SizedBox(height:10 ,),
                        const Divider(height: 5,color: Colors.teal,),
                        Text("البيانات المطلوبة للحجز",style: headingStyle(color: Colors.black, fontSize: 16) ),
                        Text("أسم الحاجز ، رقم الهاتف ، الملاحظات أن وجد",style: headingStyle(color: Colors.black, fontSize: 14) ),



                      ],
                    )
                ),
              ],
            ),
          ),
        )
    );
  }
}
