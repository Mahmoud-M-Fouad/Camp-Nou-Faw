import 'package:flutter/material.dart';

headingStyle({
  required Color color,
  required double fontSize,
}){
  return  TextStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.w300,
    overflow:TextOverflow.fade ,
    color:color,
  );
}

BoxDecoration myBoxDecoration({required Color color}) {
  return BoxDecoration(
    color: color , //Colors.green.shade600,
    border: Border.all(
        width: 3.0,
      color: Colors.indigo.shade700
    ),
    borderRadius: const BorderRadius.all(
        Radius.circular(7.0,) //
    ),
  );
}
