import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:likh_bee/Auth/OtpLogin.dart';
import 'package:likh_bee/Usefull/Avatars.dart';
import 'package:likh_bee/Usefull/Buttons.dart';
import 'package:likh_bee/Usefull/Colors.dart';
import 'package:likh_bee/Usefull/Functions.dart';
import 'package:url_launcher/url_launcher.dart';


class requestAccepted extends StatefulWidget {
  Map data;

  requestAccepted({Key? key, required this.data}) : super(key: key);

  @override
  State<requestAccepted> createState() => _requestAcceptedState();
}

class _requestAcceptedState extends State<requestAccepted> {
  bool isHide = false;
  bool sendmsg = false;
  String date = "";
  String msg = "";
  final formkey = GlobalKey<FormState>();
  late BuildContext mCtx;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    setState(() {
      date = getDate(widget.data['date']);
    });
  }

  String getDate(String date) {
    var now = DateTime.now();
    var posted = DateTime.parse(date);
    var a = now.difference(posted);

    int days = a.inDays;
    int hours = a.inHours % 24;
    int minutes = a.inMinutes % 60;
    int seconds = a.inSeconds % 60;

    if (minutes == 0) {
      date = seconds.toString() + "s ago";
    } else if (hours == 0) {
      date = minutes.toString() + "m ago";
    } else if (days == 0) {
      date = hours.toString() + "h ago";
    } else if (days != 0) {
      date = days.toString() + "d ago";
    }
    return date;
  }

  @override
  Widget build(BuildContext context) {
    mCtx = context;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: mainColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    minLeadingWidth: 0,
                    leading: circleAvatar(
                      index: widget.data['index'],
                      radius: 20.0,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mainText(widget.data['name'], textlight, 13.0,
                            FontWeight.bold, 1),
                        mainText(date, textlight, 10.0, FontWeight.normal, 1),
                      ],
                    ),
                    onTap: () {},
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  mainTextFAQS(widget.data['type'], mainColor, 15.0,
                      FontWeight.normal, 5),
                  SizedBox(
                    height: 5.0,
                  ),
                  mainTextFAQS(widget.data['title'], darktext, 20.0,
                      FontWeight.normal, 5),
                  SizedBox(
                    height: 5.0,
                  ),
                  mainTextFAQS(widget.data['desc'], lightText, 15.0,
                      FontWeight.normal, 5),
                  SizedBox(
                    height: 5.0,
                  ),
                  mainText("Price ₹" + widget.data['price'].toString() + "/-",
                      mainColor, 15.0, FontWeight.normal, 1),
                  SizedBox(
                    height: 5.0,
                  ),
                  btnsss("Accepted", () { }, mainColor, Colors.white),
                  SizedBox(height: 10.0,),
                  mainTextFAQS("Message", darktext, 17.0,
                      FontWeight.normal, 5),
                  mainTextFAQS(widget.data['accept'][user!.uid]['msg'], mainColor, 15.0,
                      FontWeight.normal, 5),
                  SizedBox(height: 10.0,),
                  Row(
                    children: [
                      mainTextFAQS(widget.data['accept'][user!.uid]['phone'], mainColor, 17.0,
                          FontWeight.normal, 1),
                      Spacer(),
                      btnsss("Call", () { _launchCaller(widget.data['accept'][user!.uid]['phone']);}, mainColor, Colors.white),

                    ],
                  ),
                  SizedBox(
                    height: 20.0,
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

  _launchCaller(String num) async {
    String url = "tel:$num";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
