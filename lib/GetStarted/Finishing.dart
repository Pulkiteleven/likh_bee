import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:likh_bee/GetStarted/Finishing.dart';
import 'package:likh_bee/Usefull/Avatars.dart';
import 'package:likh_bee/Usefull/Buttons.dart';
import 'package:likh_bee/Usefull/Colors.dart';
import 'package:likh_bee/Usefull/Functions.dart';

import '../Backend/backend.dart';

late _FinishingState stateOfAvatars;

class Finishing extends StatefulWidget {
  Map data;

  Finishing({Key? key, required this.data}) : super(key: key);

  @override
  State<Finishing> createState() {
    stateOfAvatars = _FinishingState();
    return stateOfAvatars;
  }
}

class _FinishingState extends State<Finishing> {
  bool isHide = false;
  final formKey = GlobalKey<FormState>();
  FirebaseAuth user = FirebaseAuth.instance;
  String imagesS = "";
  int imagesIndex = 0;
  List<Widget> citiesItems = [];
  List<dynamic> citiesNames = [];


  @override
  void initState() {
    print(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: Form(
                  key: formKey,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 100.0,
                        ),

                        circleAvatar(index: widget.data['aindex'], radius: 40.0),

                        SizedBox(
                          height: 15.0,
                        ),
                        mainText(widget.data['name'], darktext, 20.0, FontWeight.normal, 1),
                        SizedBox(height: 10.0,),
                        mainText(widget.data['city'], darktext, 15.0, FontWeight.normal, 1),
                        SizedBox(height: 10.0,),
                        mainText(widget.data['college'], darktext, 15.0, FontWeight.normal, 1),
                        SizedBox(height: 10.0,),
                         mainText(widget.data['what'], darktext, 15.0, FontWeight.normal, 1),
                        SizedBox(height: 10.0,),


                        SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 15.0, right: 10.0, left: 10.0),
                child: Row(
                  children: [
                    Spacer(),
                    btnsss("Submit", () {
                      stateOfAvatars.setState((){
                        stateOfAvatars.isHide = true;
                      });
                      UpdateProfile(widget.data, context);
                    }, mainColor, Colors.white),
                    Spacer()
                  ],
                ),
              ),
              loaderss(isHide, context)
            ],
          ),
        ),
      ),
    );
  }
}


