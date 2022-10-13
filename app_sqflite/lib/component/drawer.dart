import 'dart:io';

import 'package:app_sqflite/component/func.dart';
import 'package:app_sqflite/component/theme.dart';
import 'package:app_sqflite/component/widget.dart';
import 'package:flutter/material.dart';

import '../screen/drawer_screen/about_app.dart';
import '../screen/drawer_screen/profile.dart';


buildDrawer(
{
  required String accountName,
  required String accountEmail,
  required BuildContext context,
})
{
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
         UserAccountsDrawerHeader(
          accountName: Text(accountName),
          accountEmail: Text(accountEmail),

          currentAccountPicture: const CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage('images/fawlogo.PNG'),
          ),
        ),
        ListTile(
          leading: buildIcon(icon: Icons.app_blocking,color: Colors.teal),
          title: Text("التطبيق",style: headingStyle(color: Colors.black, fontSize: 16),),
          onTap: () {
            //Navigator.pop(context);AboutScreen
            navigatorTo(context: context, screen: const AboutScreen());
          },
        ),

        ListTile(
          leading: buildIcon(icon: Icons.contact_phone,color: Colors.teal),
          title: Text("اتصل بنا",style: headingStyle(color: Colors.black, fontSize: 16),),
          onTap: () {
            navigatorTo(context: context, screen: const ProfileScreen());
          },

        ),

        ListTile(
          leading: buildIcon(icon: Icons.exit_to_app,color: Colors.teal),
          title: Text("الخروج من التطبيق",style: headingStyle(color: Colors.black, fontSize: 16),),
          onTap: () {
            exit(0);
          },
        ),
      ],
    ),
  );
}