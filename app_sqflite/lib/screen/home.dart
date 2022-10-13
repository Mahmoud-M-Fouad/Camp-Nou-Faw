
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../component/drawer.dart';
import '../component/func.dart';
import '../component/theme.dart';
import '../component/widget.dart';
import 'all_hour.dart';
import 'ava_hour.dart';
import 'fixed_hour.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("الصفحة الرئيسية",style: headingStyle(color: Colors.white, fontSize: 20),),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15,),
              Text("ملعب فاو",style: headingStyle(color: Colors.teal, fontSize: 20),),
              Expanded(
                child: Lottie.asset('assets/92356-football.json'),
              ),
              Expanded(child:
                  Column(
                    children: [
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildMaterialButton(
                              text: "حجز ساعة جديدة",
                              color: Colors.indigo,
                              function: (){
                                navigatorTo(context: context, screen: const AvaHourScreen());
                              }
                          ),
                          buildMaterialButton(
                              text: "كل الساعات المحجوزة",
                              color: Colors.indigo,
                              function: (){
                                navigatorTo(context: context, screen: const AllHourScreen());
                              }
                          ),
                          buildMaterialButton(
                              text: "الساعات الثابتة إسبوعياً",
                              color: Colors.indigo,
                              function: (){
                                navigatorTo(context: context, screen: const FixedHourScreen());
                              }
                          ),
                        ],
                      )),

                    ],
                  )
              ),



            ],
          ),
        ),
        drawer:buildDrawer(
          context: context,
            accountName: "Camp Nou Faw",
            accountEmail: "ملعب فاو قبلى",

        ),
      ),
    );
  }
}
