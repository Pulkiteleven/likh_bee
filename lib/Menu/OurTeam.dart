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


class OurTeam extends StatefulWidget {

  const OurTeam({Key? key}) : super(key: key);

  @override
  State<OurTeam> createState() => _OurTeamState();
}

class _OurTeamState extends State<OurTeam> {
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
                  mainText("Our Team", darktext, 20.0, FontWeight.bold, 1),

                  SizedBox(height: 15.0,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 20.0,
                            child: ClipOval(
                              child: Image.asset('Assets/icon.png',fit: BoxFit.cover,),
                            ),
                          ),
                          SizedBox(height: 5.0,),
                          mainText("Divyanshi Gupta", darktext, 13.0, FontWeight.normal, 1),
                          mainText("Markeitng Manager", lightText, 10.0, FontWeight.normal, 1),
                        ],
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 20.0,
                            child: ClipOval(
                              child: Image.asset('Assets/icon.png',fit: BoxFit.cover,),
                            ),
                          ),
                          SizedBox(height: 5.0,),
                          mainText("Shivi Shukla", darktext, 13.0, FontWeight.normal, 1),
                          mainText("Media and Content", lightText, 10.0, FontWeight.normal, 1),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 20.0,
                            child: ClipOval(
                              child: Image.asset('Assets/icon.png',fit: BoxFit.cover,),
                            ),
                          ),
                          SizedBox(height: 5.0,),
                          mainText("Mukti Markam", darktext, 13.0, FontWeight.normal, 1),
                          mainText("Graphic Designer", lightText, 10.0, FontWeight.normal, 1),
                        ],
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 20.0,
                            child: ClipOval(
                              child: Image.asset('Assets/icon.png',fit: BoxFit.cover,),
                            ),
                          ),
                          SizedBox(height: 5.0,),
                          mainText("Pragya Shrivastav", darktext, 13.0, FontWeight.normal, 1),
                          mainText("Graphics Designer", lightText, 10.0, FontWeight.normal, 1),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 20.0,
                            child: ClipOval(
                              child: Image.asset('Assets/icon.png',fit: BoxFit.cover,),
                            ),
                          ),
                          SizedBox(height: 5.0,),
                          mainText("Yashwari", darktext, 13.0, FontWeight.normal, 1),
                          mainText("Media and Marketing", lightText, 10.0, FontWeight.normal, 1),
                        ],
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 20.0,
                            child: ClipOval(
                              child: Image.asset('Assets/icon.png',fit: BoxFit.cover,),
                            ),
                          ),
                          SizedBox(height: 5.0,),
                          mainText("Salil Sharma", darktext, 13.0, FontWeight.normal, 1),
                          mainText("Web Developer", lightText, 10.0, FontWeight.normal, 1),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 20.0,
                            child: ClipOval(
                              child: Image.asset('Assets/icon.png',fit: BoxFit.cover,),
                            ),
                          ),
                          SizedBox(height: 5.0,),
                          mainText("Pulkit Developer", darktext, 13.0, FontWeight.normal, 1),
                          mainText("App Developer", lightText, 10.0, FontWeight.normal, 1),
                        ],
                      ),
                    ],
                  ),
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
