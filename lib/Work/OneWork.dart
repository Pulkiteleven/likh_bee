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
import 'package:intl/intl.dart';


class oneWork extends StatefulWidget {
  Map data;

  oneWork({Key? key, required this.data}) : super(key: key);

  @override
  State<oneWork> createState() => _oneWorkState();
}

class _oneWorkState extends State<oneWork> {
  bool isHide = false;
  bool sendmsg = false;
  String date = "";
  String msg = "";
  final formkey = GlobalKey<FormState>();
  late BuildContext mCtx;
  String dateBy = "";
  String timeBy = "";
  DateTime now = DateTime.now();

  @override
  void initState() {
    setState(() {
      date = getDate(widget.data['date']);
      dateBy = DateFormat('EEE dd LLL').format(now);

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
                  SizedBox(
                    height: 20.0,
                  ),
                  btnsss("Likh Bee", () {
                    popUp();
                  }, lightColor, Colors.white),
                  Visibility(
                      visible: sendmsg,
                      child: Card(
                        elevation: 5.0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 5.0),
                              child: Form(
                                key: formkey,
                                child: (Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    mainText("Request", darktext, 15.0,
                                        FontWeight.normal, 1),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    TextFormField(
                                      minLines: 1,
                                      maxLines: 5,
                                      keyboardType: TextInputType.multiline,
                                      style: TextStyle(
                                          color: textlight,
                                          fontSize: 12.0,
                                          fontFamily: 'pop'),
                                      decoration: InputDecoration(
                                        hintText: "Enter Your Message",
                                        // labelText: "Add Title",
                                        labelStyle: TextStyle(
                                          color: textlight,
                                          fontFamily: 'pop',
                                          fontSize: 15.0,
                                        ),
                                        errorStyle: TextStyle(
                                          color: errorColor,
                                          fontFamily: 'pop',
                                          fontSize: 10.0,
                                        ),
                                      ),
                                      onChanged: (text) {
                                        msg = text;
                                        print(text);
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty || value == null) {
                                          return ("Please Enter an Message");
                                        }
                                      },
                                    ),
                                    SizedBox(height: 5.0),
                                    mainText("You want this work done by", darktext, 15.0,
                                        FontWeight.normal, 1),
                                    SizedBox(height: 5.0,),
                                    Row(
                                      children: [
                                        btnsss(dateBy, () { getDateBy();}, yellowColor, Colors.white),
                                        SizedBox(width: 3.0,),

                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      children: [
                                        Spacer(),
                                        btnsss("Send Request", () {
                                          sendRequest();
                                        }, lightColor, Colors.white)
                                      ],
                                    )
                                  ],
                                )),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            loaderss(isHide, context)
          ],
        ),
      ),
    );
  }

  getDateBy() async{
    var pickedDate = (await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100)));
    if(pickedDate != null){
      setState((){
        now = pickedDate;
        dateBy = DateFormat('EEE dd LLL').format(pickedDate);
      });
    }
  }

  popUp() {
    setState(() {
      sendmsg = true;
    });
  }

  sendRequest() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        isHide = true;
      });
      User? user = FirebaseAuth.instance.currentUser;
      Map<String, dynamic> item = {
        user!.uid.toString(): {'msg': msg,'time':now.toString()}
      };
      var ref = FirebaseDatabase.instance.reference();
      ref
          .child('works')
          .child(widget.data['id'])
          .child('requests')
          .update(item)
          .then((value) => {
            saveRequest(widget.data['id'], msg,now)
      });
    }
  }

  saveRequest(String workid, String msg,DateTime times) {
    var ref = FirebaseDatabase.instance.reference();
    User? user = FirebaseAuth.instance.currentUser;

    Map<String, dynamic> item = {
      workid: {'msg': msg,'date':times.toString()}
    };

    ref.child('userRequests').child(user!.uid).update(item).then((value) => {
          snacker("Your Request has been Send Succesfully", mCtx),
          setState(() {
            sendmsg = false;
            isHide = false;
          })
        });
  }
}
