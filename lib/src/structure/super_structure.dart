import 'package:flutter/material.dart';

abstract class SuperStructure extends StatefulWidget{
  final String image;
  final GlobalKey globalKey;

  SuperStructure(this.image,this.globalKey);

  @override
  Widget build(BuildContext context) {
    return build(context);
  }
}