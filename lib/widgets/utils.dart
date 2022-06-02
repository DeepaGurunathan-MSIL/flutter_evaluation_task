import 'package:flutter/material.dart';

class Utils {

  // Base App Bar
  AppBar baseAppBar ({String? title})
  {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.grey[350],
      elevation: 0.0,
      bottomOpacity: 0.0,
      title: Center(
        child: Text(title!,style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15
        ),),
      ),
    );
  }

  // Rectangular Border

  ShapeDecoration shapeDecoration ({Color? color})
  {
    return ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder (
        borderRadius: BorderRadius.circular(5.0),
    side:  BorderSide(
    color: color!
    )
    ));
  }

  SnackBar snackBar (String message)
  {
    return SnackBar(
      content: Text(message),
    );
  }
}