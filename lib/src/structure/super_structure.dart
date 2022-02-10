import 'package:business_card_generator/src/structure/stack_type_general.dart';
import 'package:flutter/material.dart';
class SuperStructure extends StackTypeGeneral{
  final String image;
  final GlobalKey globalKey;

  SuperStructure(this.image,this.globalKey) :super(image,globalKey,'','');
}