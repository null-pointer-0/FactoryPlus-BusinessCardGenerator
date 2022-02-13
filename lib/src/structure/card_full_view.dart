import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/rendering.dart';

import '../size_of_widget.dart';

class CardFullView extends StatefulWidget {
  final String image;
  final GlobalKey globalKey;
  String name, contactNumber;


  CardFullView(this.image,this.globalKey,this.name,this.contactNumber);

  @override
  _CardFullViewState createState() => _CardFullViewState();
}

class _CardFullViewState extends State<CardFullView> {
  ValueNotifier<double> imageWidth = ValueNotifier(0.0);
  Uint8List? imageInMemory = Uint8List.fromList(List.empty(growable: true));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              capturePng(widget.globalKey).then((value) {});
            },
            child: const Icon(
              Icons.share,
              size: 35,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: Colors.black26,
        iconTheme: const IconThemeData(color: Colors.black54),
        elevation: 0,
      ),
      body: RepaintBoundary(
        key: widget.globalKey,
        child: Hero(
          tag: widget.image,
          child: Stack(
            children: [
              SizeOffsetWrapper(
                onSizeChange: (Size size) {
                  imageWidth.value = size.width;
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 90.0,horizontal: 10.0),
                  child: Image.asset(
                    widget.image,
                    height: MediaQuery.of(context).size.height * 0.56,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              _contactWidget(),
              _nameAndDetailWidget(),
            ],
          ),
        ),
      ),
    );
  }
  Widget _contactWidget() {
    return ValueListenableBuilder(
      valueListenable: imageWidth,
      builder: (context, value, child) {
        return Positioned(
          child:  Text(
            widget.contactNumber,
            style: const TextStyle(
                fontSize: 22.0,
                color: Colors.red,
                fontWeight: FontWeight.bold),
          ),
          top: MediaQuery.of(context).size.height * 0.66 * 0.85,
          right: 12.0,
        );
      },
    );
  }

  Widget _nameAndDetailWidget() {
    return ValueListenableBuilder(
      valueListenable: imageWidth,
      builder: (context, value, child) {
        return Positioned(
          top: MediaQuery.of(context).size.height * 0.72 * 0.45,
          width: imageWidth.value,
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.name,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 32.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
  Future<Uint8List?> capturePng(GlobalKey _globalKey) async {
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
      List<String> paths = List.empty(growable: true);
      paths.add('$directory/flutter.png');
      Share.shareFiles(paths,
          subject: 'Share ScreenShot',
          sharePositionOrigin:
          boundary!.localToGlobal(Offset.zero) & boundary.size);
      setState(() {
        imageInMemory = pngBytes;
      });
      return pngBytes;
    } catch (e) {
      return null;
    }
  }
}



