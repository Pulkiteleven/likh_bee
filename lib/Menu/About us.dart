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


class aboutUs extends StatefulWidget {

  const aboutUs({Key? key}) : super(key: key);

  @override
  State<aboutUs> createState() => _aboutUsState();
}

class _aboutUsState extends State<aboutUs> {
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  mainText("About Us", darktext, 20.0, FontWeight.bold, 1),

                  SizedBox(height: 15.0,),
                  CircleAvatar(
                    radius: 40.0,
                    child: ClipOval(
                      child: Image.asset('Assets/icon.png',fit: BoxFit.cover,),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  mainTextPop("LikhBee", mainColor, 15.0, FontWeight.normal,1),
                  SizedBox(height: 5.0,),
                  mainTextPop("Pay, Write and Hire", mainColor, 15.0, FontWeight.normal,1),

                  
                  SizedBox(height:15.0,),
                  mainText(""" We LikhBEE ,aims to create an online community where you can hire young professionals to provide quality work & materials to our young minded students.

Our focus
We delve into a myriad of smart and agile academic tools and shape up your academic aspirations like a champ.Our focus is to give support & quality work to dedicated students when they need us.

Our mission
Our mission is to provide Excellent support along with quality work & materials include academic papers of varying complexity and other personalized services, along with academic materials for assistance purposes.

Our goal is to stand on the student’s requirement by offering them high-quality services without putting the burden of expense.We assist you to optimize your performance and be a step ahead in competition. """, darktext, 15.0, FontWeight.normal, 30),
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
