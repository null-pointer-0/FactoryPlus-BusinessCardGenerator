import 'package:business_card_generator/src/size_of_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StackTypeGeneral extends StatefulWidget {
  final String image;
  final GlobalKey globalKey;
  String name,contactNumber;
  StackTypeGeneral(this.image, this.globalKey,this.name,this.contactNumber);

  @override
  _StackTypeGeneralState createState() => _StackTypeGeneralState();
}

class _StackTypeGeneralState extends State<StackTypeGeneral> {
  ValueNotifier<double> imageWidth = ValueNotifier(0.0);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: widget.globalKey,
      child: Stack(
        children: [
          SizeOffsetWrapper(
            onSizeChange: (Size size) {
              imageWidth.value = size.width;
            },
            child: Image.asset(
              widget.image,
              package: 'business_card_generator',
              height: MediaQuery.of(context).size.height * 0.27,
              fit: BoxFit.fitHeight,
            ),
          ),
          _contactWidget(),
          _nameAndDetailWidget(),
        ],
      ),
    );
  }

  Widget _contactWidget() {
    return ValueListenableBuilder(
      valueListenable: imageWidth,
      builder: (context, value, child) {
        return Positioned(
          child: Text(
            widget.contactNumber,
            style: const TextStyle(
                fontSize: 16.0,
                color: Colors.red,
                fontWeight: FontWeight.bold),
          ),
          top: MediaQuery.of(context).size.height * 0.27 * 0.85,
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
          top: MediaQuery.of(context).size.height * 0.27 * 0.45,
          width: imageWidth.value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.name,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 24.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
