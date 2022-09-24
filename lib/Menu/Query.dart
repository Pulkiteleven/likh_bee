import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:likh_bee/FlutterAloo.dart';
import 'package:likh_bee/Mains/AllWork.dart';
import 'package:likh_bee/Mains/PostWork.dart';
import 'package:likh_bee/Mains/nayaAloo.dart';
import 'package:likh_bee/Usefull/Avatars.dart';
import 'package:likh_bee/Usefull/Buttons.dart';
import 'package:likh_bee/Usefull/Colors.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:likh_bee/Usefull/Functions.dart';
import 'package:likh_bee/Work/OneWork.dart';


class query extends StatefulWidget {

  const query({Key? key}) : super(key: key);

  @override
  State<query> createState() => _queryState();
}

class _queryState extends State<query> {
  bool isHide = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.close,color: mainColor,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  mainText("Raise a Query", darktext, 20.0, FontWeight.bold, 1),

                  SizedBox(height: 15.0,),
                  mainText("Raise your query", lightText, 15.0, FontWeight.normal, 1),
                  SizedBox(height: 15.0,),


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
