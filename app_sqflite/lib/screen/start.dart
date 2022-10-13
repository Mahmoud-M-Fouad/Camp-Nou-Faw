import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../component/func.dart';
import '../component/theme.dart';
import '../component/widget.dart';
import 'home.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.black38,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'ملعب فاو قبلى',
                  style: headingStyle(color: Colors.indigo, fontSize: 24),
                ),
              ),
              Expanded(
                child: Lottie.asset('assets/42712-football-stadium.json'),
              ),
              Column(
                children: [
                  buildMaterialButton(
                      text: "فتح التطبيق",
                      color: Colors.indigo,
                      function: () {
                        navigatorToEnd(
                            context: context, screen: const HomeScreen());
                      })
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      'ملعب خماسى',
                      style: headingStyle(color: Colors.black, fontSize: 14),
                    ),
                    Text(
                      'العمل كل الأيام ',
                      style: headingStyle(color: Colors.black, fontSize: 14),
                    ),
                    Text(
                      'مكان الملعب ------------- ',
                      style: headingStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
