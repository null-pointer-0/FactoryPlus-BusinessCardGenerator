import 'package:business_card_generator/src/Data/Asset.dart';
import 'package:business_card_generator/src/structure/stack_type_general.dart';
import 'package:flutter/material.dart';

class TotalCards {
  String name, contactNumber;

  TotalCards(this.name, this.contactNumber);

  List<Widget> _totalCards = List.empty(growable: true);

  void _populateList() {
    _totalCards = [
      StackTypeGeneral(
          Assets.card_background_one, GlobalKey(), name, contactNumber),
      StackTypeGeneral(
          Assets.card_background_two, GlobalKey(), name, contactNumber),
      StackTypeGeneral(
          Assets.card_background_third, GlobalKey(), name, contactNumber),
      StackTypeGeneral(
          Assets.card_background_one, GlobalKey(), name, contactNumber),
      StackTypeGeneral(
          Assets.card_background_third, GlobalKey(), name, contactNumber),
      StackTypeGeneral(
          Assets.card_background_two, GlobalKey(), name, contactNumber),
    ];
  }

  List<Widget> getTotalCards() {
    _populateList();
    return _totalCards;
  }

  List<Widget> fetchMoreData(int index) {
    List<Widget> _tempList = List.empty(growable: true);
    if (index < _totalCards.length) {
      for (int i = index; i < _totalCards.length; i++) {
        _tempList.add(_totalCards[i]);
      }
    }
    return _tempList;
  }

  List<Widget> getInitialData() {
    List<Widget> _tempList = List.empty(growable: true);
    for (int i = 0; i < 3; i++) {
      _tempList.add(_totalCards[i]);
    }
    return _tempList;
  }
}
