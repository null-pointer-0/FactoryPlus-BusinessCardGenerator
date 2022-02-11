import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:business_card_generator/src/Data/total_card.dart';
import 'package:business_card_generator/src/structure/super_structure.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/rendering.dart';

class BusinessCardGenerator extends StatefulWidget {
  String name;
  String contactNumber;
  Widget? shareButton;
  Color? shareButtonColor;
  String? shareButtonText;
  double? shareButtonFontSize;
  VoidCallback? changeValues;

  BusinessCardGenerator(
    this.name,
    this.contactNumber, {
    this.shareButton,
    this.shareButtonColor,
    this.shareButtonFontSize,
    this.shareButtonText,
    this.changeValues,
  });

  @override
  _BusinessCardGeneratorState createState() => _BusinessCardGeneratorState();
}

class _BusinessCardGeneratorState extends State<BusinessCardGenerator> {
  late final TotalCards _totalCardsClass;
  List<Widget> totalCards = List.empty(growable: true);
  Uint8List? imageInMemory = Uint8List.fromList(List.empty(growable: true));
  int curIndex = 0;
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 0.9);

  @override
  void initState() {
    super.initState();
    _totalCardsClass = TotalCards(widget.name, widget.contactNumber);
    totalCards = _totalCardsClass.getInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget To Image demo'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            _cardsView(),
            _shareButton(),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardsView() {
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.27),
      child: PageView.builder(
        itemCount: totalCards.length,
        controller: _pageController,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: totalCards[index],
          );
        },
        onPageChanged: (index) {
          _onPageChange(index);
        },
      ),
    );
  }

  Widget _shareButton() {
    return Flexible(
      child: InkWell(
        onTap: () {
          _capturePng((totalCards[curIndex] as SuperStructure).globalKey)
              .then((value) {});
        },
        child: widget.shareButton != null
            ? Container(
                color: Colors.blue,
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  'Capture Image',
                  style: TextStyle(fontSize: 20.0),
                ),
              )
            : widget.shareButton,
      ),
    );
  }

  Future<Uint8List?> _capturePng(GlobalKey _globalKey) async {
    try {
      RenderRepaintBoundary? boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary?;
      ui.Image? image = await boundary?.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image?.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? pngBytes = byteData?.buffer.asUint8List();
      final directory = (await getExternalStorageDirectory())?.path;
      File imgFile = File('$directory/flutter.png');
      imgFile.writeAsBytesSync(pngBytes!);
      Share.share(
        '$directory/flutter.png',
        sharePositionOrigin:
            boundary!.localToGlobal(Offset.zero) & boundary.size,
      );
      setState(() {
        imageInMemory = pngBytes;
      });
      return pngBytes;
    } catch (e) {
      return null;
    }
  }

  _onPageChange(int index) {
    setState(() {
      curIndex = index;
      if (index == totalCards.length - 2) {
        for (var value in _totalCardsClass.fetchMoreData(totalCards.length)) {
          totalCards.add(value);
        }
      }
    });
  }
}
