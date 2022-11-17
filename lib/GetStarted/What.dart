import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:likh_bee/GetStarted/Avatar.dart';
import 'package:likh_bee/GetStarted/Finishing.dart';
import 'package:likh_bee/Usefull/Buttons.dart';
import 'package:likh_bee/Usefull/Colors.dart';
import 'package:likh_bee/Usefull/Functions.dart';

class what extends StatefulWidget {
  Map data;
  what({Key? key,required this.data}) : super(key: key);

  @override
  State<what> createState() => _whatState();
}

class _whatState extends State<what> {
  bool isHide = false;
  final formKey = GlobalKey<FormState>();
  String name = "";

  List<Widget> citiesItems = [];
  List<dynamic> citiesNames = [];
  Map data = {};

  @override
  void initState() {
    data = widget.data;
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
                          height: 70.0,
                        ),
                        Image.asset(
                          'Assets/work.png',
                          width: MediaQuery.of(context).size.width * 0.60,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        mainText("What you wanted to Do", mainColor, 25.0,
                            FontWeight.normal, 1),
                        SizedBox(
                          height: 15.0,
                        ),
                        btnsss("Wanted to Work", () {
                          data['work'] = true;
                          data['what'] = "Wanted to Work";
                          navScreen(avatar(data: data), context, false);
                        }, mainColor, Colors.white),
                        SizedBox(height: 5.0,),
                        btnsss("Wanted to Hire", () {
                          data['work'] = false;
                          data['what'] = "Wanted to Hire";
                          navScreen(avatar(data: data), context, false);
                        }, yellowColor, mainColor),

                      ],
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 15.0,right: 10.0,left: 10.0),
                child: Row(
                  children: [
                    Spacer(),
                    // btnsss("Next", () { if(formKey.currentState!.validate()){
                    //
                    // }}, mainColor, Colors.white)
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

class listItems extends StatefulWidget {
  String title;
  listItems({Key? key,required this.title}) : super(key: key);

  @override
  State<listItems> createState() => _listItemsState();
}

class _listItemsState extends State<listItems> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
        child: mainText(
            widget.title, mainColor, 13.0, FontWeight.normal,1),
      ),
      style: ButtonStyle(
          foregroundColor:
          MaterialStateProperty.all<Color>(
              Colors.white),
          backgroundColor:
          MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<
              RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(15.0),
                  side: BorderSide(color: Colors.white)))),
      onPressed: (){

      },
    );
  }
}

