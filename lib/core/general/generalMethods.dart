import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GeneralMethods {

  static void navigateTo(BuildContext context, widget)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  static void replaceWith(BuildContext context, widget) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => widget));
  }

}