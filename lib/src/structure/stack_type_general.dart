import 'package:business_card_generator/src/size_of_widget.dart';
import 'package:business_card_generator/src/structure/super_structure.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StackTypeGeneral extends SuperStructure{
  final String email;
  final String address;
  final String image;
  final GlobalKey globalKey;
  String name, contactNumber;

  StackTypeGeneral(this.image, this.globalKey, this.name, this.contactNumber,this.email,this.address):super(image,globalKey);

  @override
  _StackTypeGeneralState createState() => _StackTypeGeneralState();
}

class _StackTypeGeneralState extends State<StackTypeGeneral> {
  ValueNotifier<double> imageWidth = ValueNotifier(0.0);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: widget.globalKey,
      child:  Stack(
        children: [
          SizeOffsetWrapper(
            onSizeChange: (Size size) {
              imageWidth.value = size.width;
            },
              child: Image.asset(
                widget.image,
                height: MediaQuery.of(context).size.height * 0.27,
                fit: BoxFit.fitHeight,
              ),
          ),
          _details(),
          _nameAndDetailWidget(),
          _emailWidget(),

        ],
      ),
    );
  }
  Widget _rowTileContainingInfo(widgetType,iconType){
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          iconType,
          size: 15,
        ),
        const SizedBox(width: 8,),
        Container(
          child: widgetType,
        )
      ],
    );
  }
  Widget _details() {
    return ValueListenableBuilder(
      valueListenable: imageWidth,
      builder: (context, value, child) {
        return Positioned(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _rowTileContainingInfo(_addressWidget(),Icons.email),
              _rowTileContainingInfo(_contactWidget(),Icons.add),
            ],
          ),
          top: MediaQuery.of(context).size.height * 0.21 * 0.85,
        );
      },
    );
  }
  Widget _contactWidget() {
    return const Text(
      '7982611621',
      style: TextStyle(
          fontSize: 10.0,
          color: Colors.red,
          fontWeight: FontWeight.bold),
    );
  }

  Widget _addressWidget() {
    return const Text(
      'G01 EPI colony ,Near Gate number 2',
      style: TextStyle(
          fontSize: 10.0,
          color: Colors.red,
          fontWeight: FontWeight.bold),
    );
  }

  Widget _nameAndDetailWidget() {
    return ValueListenableBuilder(
      valueListenable: imageWidth,
      builder: (context, value, child) {
        return Positioned(
          top: MediaQuery.of(context).size.height * 0.27 * 0.45,
          width: imageWidth.value,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Mark Enterprises',
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
  Widget _emailWidget() {
    return ValueListenableBuilder(
      valueListenable: imageWidth,
      builder: (context, value, child) {
        return Positioned(
          top: MediaQuery.of(context).size.height * 0.29 * 0.85,
          width: imageWidth.value,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'prashantsingh@gmail.com',
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10.0,
                color: Colors.red,
              ),
            ),
          ),
        );
      },
    );
  }
}

