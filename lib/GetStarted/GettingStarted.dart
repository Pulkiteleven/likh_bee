import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:likh_bee/GetStarted/Finishing.dart';
import 'package:likh_bee/Usefull/Buttons.dart';
import 'package:likh_bee/Usefull/Colors.dart';
import 'package:likh_bee/Usefull/Functions.dart';

final _messangerKey = GlobalKey<ScaffoldMessengerState>();


class gettingStarted extends StatefulWidget {
  const gettingStarted({Key? key}) : super(key: key);

  @override
  State<gettingStarted> createState() => _gettingStartedState();
}

class _gettingStartedState extends State<gettingStarted> {
  final formKey = GlobalKey<FormState>();
  bool isHide = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<Widget> startItems = [];


  @override
  void initState() {
    setState((){

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messangerKey,
      home: Scaffold(
        backgroundColor:
        bgColor,
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
              child: Column(
                children: [

                ],
              ),
            ),

            loaderss(isHide, context)
          ],
        ),
      ),
    );
  }
}
