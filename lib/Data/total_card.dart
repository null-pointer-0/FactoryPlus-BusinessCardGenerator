import 'package:business_card_generator/Data/Asset.dart';
import 'package:business_card_generator/structure/stack_type_general.dart';
import 'package:flutter/material.dart';

class TotalCards {
  final List<Widget> _totalCards = [
    StackTypeGeneral(Assets.card_background_one, GlobalKey()),
    StackTypeGeneral(Assets.card_background_two, GlobalKey()),
    StackTypeGeneral(Assets.card_background_third, GlobalKey()),
    StackTypeGeneral(Assets.card_background_one, GlobalKey()),
    StackTypeGeneral(Assets.card_background_third, GlobalKey()),
    StackTypeGeneral(Assets.card_background_two, GlobalKey()),
  ];

  List<Widget> getTotalCards() {
    return _totalCards;
  }
}
