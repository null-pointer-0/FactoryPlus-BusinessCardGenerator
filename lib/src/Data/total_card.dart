import 'package:business_card_generator/src/Data/Asset.dart';
import 'package:business_card_generator/src/structure/stack_type_general.dart';
import 'package:flutter/material.dart';

class TotalCards {
  String name,contactNumber;

  TotalCards(this.name, this.contactNumber);
  List<Widget> _totalCards = List.empty(growable: true);

  void _populateList(){
    _totalCards = [
      StackTypeGeneral(Assets.card_background_one, GlobalKey(),name ,contactNumber),
      StackTypeGeneral(Assets.card_background_two, GlobalKey(),name ,contactNumber),
      StackTypeGeneral(Assets.card_background_third, GlobalKey(),name ,contactNumber),
      StackTypeGeneral(Assets.card_background_one, GlobalKey(),name ,contactNumber),
      StackTypeGeneral(Assets.card_background_third, GlobalKey(),name ,contactNumber),
      StackTypeGeneral(Assets.card_background_two, GlobalKey(),name ,contactNumber),
    ];
  }

  List<Widget> getTotalCards() {
    _populateList();
    return _totalCards;
  }
}
