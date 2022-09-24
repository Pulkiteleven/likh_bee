import 'package:flutter/material.dart';

import 'Usefull/Colors.dart';

class alooDart extends StatefulWidget {
  Widget bodies;
  String title;

  alooDart({Key? key, required this.title, required this.bodies})
      : super(key: key);

  @override
  State<alooDart> createState() => _alooDartState();
}

class _alooDartState extends State<alooDart> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              leading:  FloatingActionButton(
                mini: true,
                elevation: 0.0,
                backgroundColor: Colors.white,
                child: Icon(Icons.close,color: mainColor,),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),

            body: widget.bodies));
  }
}
