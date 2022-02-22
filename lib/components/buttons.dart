import '../assets/Colors.dart' as projectColor;
import 'package:flutter/material.dart';

Widget btPrimary({context, required String lable, call, TextStyle? textStyle}) {
  return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        onPressed: call,
        child: Text(
          lable,
          style: textStyle != null ? textStyle : TextStyle(),
        ),
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(projectColor.primary)),
      ));
}

Widget btText({context, required String lable, call, TextStyle? textStyle}) {
  return TextButton(
      onPressed: call,
      child: Text(
        lable,
        style: textStyle != null ? textStyle : TextStyle(),
      ));
}
