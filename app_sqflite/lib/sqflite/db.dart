
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../component/func.dart';
import '../model/faw_model.dart';
import '../screen/all_hour.dart';
import '../screen/ava_hour.dart';

late final Future<Database> database;
Future<void> createDatabase() async
{
  database = openDatabase(
    join(await getDatabasesPath() ,
        'faw_db00.db'),
    onCreate: (db , version)
    {
      return db.execute("CREATE TABLE faw (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,"
          " name TEXT NOT NULL ,phone TEXT NOT NULL,"
          "date TEXT NOT NULL,day TEXT NOT NULL,"
          "hour TEXT NOT NULL,type TEXT NOT NULL,"
          "notes TEXT NOT NULL,money TEXT NOT NULL,weekly TEXT NOT NULL ) "
      ).then((value){
        print("Database Created");
        var person = Faw(id: 0,
            name: "name",
            date: "date",
            phone: 'phone',
            type: 'type',
            money: 'money',
            notes: 'notes',
            day: 'day',
            hour: 'hour',
            weekly: 'weekly',
        );
        initial(person);
      });

    },
    version: 1,
    onOpen: (db){
      resWeekly();
      print("Database Opened");
    }
  );

}

Future<void> initial(Faw f)async
{
  final Database db = await database;
  await db.insert('faw', f.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<void> insertHour(Faw f ,  BuildContext context)async
{
  final Database db = await database;
  await db.insert('faw', f.toJson(), conflictAlgorithm: ConflictAlgorithm.replace
  ).then((value) {
    showAweSomeDialogYes(
      context: context,
      body: "تم حجز الساعة بنجاح",
      dialogType: DialogType.success,
      colorBorder: Colors.green,
      funOk: (){
        Navigator.pop(context);
        Navigator.pop(context);
        navigatorTo(context: context, screen: const AvaHourScreen());
      }
    );
  }
  ).catchError((e){
    showAweSomeDialogYes(
        context: context,
        body: "فشل حجز الساعة",
        dialogType: DialogType.error,
        colorBorder: Colors.red,
        funOk: (){}
    );
  });
}

Future<List<Faw>> allHour({required String date}) async
{
  final Database db =await database;
  final List<Map<String , dynamic>> map = await db.query('faw' ,
      where: "id != ? and  date = ? ",orderBy: "type"  , whereArgs: [0 , date]
  );
  return List.generate(map.length,
          (index)
      {
        return Faw(
          id: map[index]['id'],
          name: map[index]['name'],
          phone: map[index]['phone'],
          date: map[index]['date'],
          day: map[index]['day'],
          hour: map[index]['hour'],
          type: map[index]['type'],
          notes: map[index]['notes'],
          money: map[index]['money'],
          weekly: map[index]['weekly'],

        );
      }
  );
}

Future<void> deleteHour(int id ,BuildContext context)async
{
  final db = await database ;
  await db.delete('faw', where: "id = ? " , whereArgs: [id]
  ).then((value) {
    showAweSomeDialogYes(
        context: context,
        body: "تم حذف الساعة بنجاح",
        dialogType: DialogType.success,
        colorBorder: Colors.green,
        funOk: (){
        }
    );
  }).catchError((error)
  {
    showAweSomeDialogYes(
        context: context,
        body: "فشل حذف هذا الساعة ",
        dialogType: DialogType.success,
        colorBorder: Colors.green,
        funOk: (){
        }
    );
  });
}

Future<int> maxID() async
{
  var id;
  final Database db =await database;
   id = Sqflite.firstIntValue(await db.rawQuery('SELECT max(id) FROM faw'));
  return id;
}

allFixedHour({required String day}) async
{
  final Database db =await database;
  final List<Map<String , dynamic>> map = await db.query('faw' ,
      where: "weekly = ? and day = ? ",orderBy: "type" , whereArgs: ["true" , day]
  );
  return List.generate(map.length,
          (index)
      {
        return Faw(
          id: map[index]['id'],
          name: map[index]['name'],
          phone: map[index]['phone'],
          date: map[index]['date'],
          day: map[index]['day'],
          hour: map[index]['hour'],
          type: map[index]['type'],
          notes: map[index]['notes'],
          money: map[index]['money'],
          weekly: map[index]['weekly'],

        );
      }
  );
}

allHourPm(String date) async
{
  final Database db =await database;
  final List<Map<String , dynamic>> map = await db.query('faw' ,
      where: "(date = ? and type = ?) or (weekly = ? and type = ? and day = ?)" , whereArgs: [date , "مساءاً" ,"true", "مساءاً",gatDay(currentDate: date)]
  );
  return List.generate(map.length,
          (index)
      {
        return map[index]['hour'];
      }
  );
}

allHourAm(String date) async
{
  final Database db =await database;
  final List<Map<String , dynamic>> map = await db.query('faw' ,
      where: "(date = ? and type = ?) or (weekly = ? and type = ? and day = ?)" , whereArgs: [date , "صباحاً" ,"true", "صباحاً",gatDay(currentDate: date)]
  );
  return List.generate(map.length,
          (index)
      {
        return map[index]['hour'];
      }
  );
}

Future<List<Faw>> hourWithId({required int id}) async
{
  final Database db =await database;
  final List<Map<String , dynamic>> map = await db.query('faw' ,
      where: "id = ?" , whereArgs: [id]
  );
  return List.generate(map.length,
          (index)
      {
        return Faw(
          id: map[index]['id'],
          name: map[index]['name'],
          phone: map[index]['phone'],
          date: map[index]['date'],
          day: map[index]['day'],
          hour: map[index]['hour'],
          type: map[index]['type'],
          notes: map[index]['notes'],
          money: map[index]['money'],
          weekly: map[index]['weekly'],

        );
      }
  );
}

Future<void> updateName({required String name,required int id,required BuildContext context})async
{
  final db = await database ;
  await db.rawUpdate('UPDATE faw SET name = ? WHERE id = ?', [name, id]).
  then((value) {
    showAweSomeDialogYes(
        context: context,
        body: "تم تعديل الأسم بنجاح",
        dialogType: DialogType.success,
        colorBorder: Colors.green,
        funOk: (){
          Navigator.pop(context);
          Navigator.pop(context);
          navigatorTo(context: context, screen: const AllHourScreen());
        }
    );
  }
  ).catchError((e){
    showAweSomeDialogYes(
        context: context,
        body: "فشل تعديل الأسم",
        dialogType: DialogType.error,
        colorBorder: Colors.red,
        funOk: (){
          //Navigator.pop(context);
          //navigatorToEnd(context: context, screen: const AvaHourScreen());
        }
    );
  });
}

Future<void> updateWeekly({required String weekly,required int id,required BuildContext context})async
{
  final db = await database ;
  await db.rawUpdate('UPDATE faw SET weekly = ? WHERE id = ?', [weekly, id]).
  then((value) {
    showAweSomeDialogYes(
        context: context,
        body: "تم تعديل الحجز الأسبوعى بنجاح",
        dialogType: DialogType.success,
        colorBorder: Colors.green,
        funOk: (){
          //Navigator.pop(context);
        }
    );
  }
  ).catchError((e){
    showAweSomeDialogYes(
        context: context,
        body: "فشل تعديل الحجز الأسبوعى",
        dialogType: DialogType.error,
        colorBorder: Colors.red,
        funOk: (){
          //Navigator.pop(context);
        }
    );
  });
}

Future<void> updateMoney({required String money,required int id,required BuildContext context})async
{
  final db = await database ;
  await db.rawUpdate('UPDATE faw SET money = ? WHERE id = ?', [money, id]).
  then((value) {
    showAweSomeDialogYes(
        context: context,
        body: "تم تعديل فلوس الحجز بنجاح",
        dialogType: DialogType.success,
        colorBorder: Colors.green,
        funOk: (){
          //Navigator.pop(context);
          //navigatorToEnd(context: context, screen: const AvaHourScreen());
        }
    );
  }
  ).catchError((e){
    showAweSomeDialogYes(
        context: context,
        body: "فشل تعديل فلوس الحجز",
        dialogType: DialogType.error,
        colorBorder: Colors.red,
        funOk: (){
          //Navigator.pop(context);
          //navigatorToEnd(context: context, screen: const AvaHourScreen());
        }
    );
  });
}

Future<void> updateNotes({required String notes,required int id,required BuildContext context})async
{
  final db = await database ;
  await db.rawUpdate('UPDATE faw SET notes = ? WHERE id = ?', [notes, id]).
  then((value) {
    showAweSomeDialogYes(
        context: context,
        body: "تم تعديل الملاحظات بنجاح",
        dialogType: DialogType.success,
        colorBorder: Colors.green,
        funOk: (){
          //Navigator.pop(context);
          //navigatorToEnd(context: context, screen: const AvaHourScreen());
        }
    );
  }
  ).catchError((e){
    showAweSomeDialogYes(
        context: context,
        body: "فشل تعديل الملاحظات",
        dialogType: DialogType.error,
        colorBorder: Colors.red,
        funOk: (){
          //Navigator.pop(context);
          //navigatorToEnd(context: context, screen: const AvaHourScreen());
        }
    );
  });
}

Future<void> resWeekly()async
{
  String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
  final db = await database ;
  await db.rawUpdate('UPDATE faw SET date = ? WHERE weekly = ? and day = ?',
      [date,"true",gatDay(currentDate: date)]);
}