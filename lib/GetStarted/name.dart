import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:likh_bee/GetStarted/Finishing.dart';
import 'package:likh_bee/GetStarted/city.dart';
import 'package:likh_bee/Usefull/Buttons.dart';
import 'package:likh_bee/Usefull/Colors.dart';
import 'package:likh_bee/Usefull/Functions.dart';

class name extends StatefulWidget {
  const name({Key? key}) : super(key: key);

  @override
  State<name> createState() => _nameState();
}

class _nameState extends State<name> {
  bool isHide = false;
  final formKey = GlobalKey<FormState>();
  String name = "";

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 70.0,
                      ),
                      Image.asset(
                        'Assets/user.png',
                        width: MediaQuery.of(context).size.width * 0.60,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      mainText("Enter Your User Name", mainColor, 25.0,
                          FontWeight.normal, 1),
                      SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          maxLength: 20,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.white,
                          style: TextStyle(
                            fontFamily: 'pop',
                            fontSize: 15.0,
                            color: textColor,
                          ),
                          decoration: InputDecoration(
                              hintText: "@UserName",
                              labelStyle: TextStyle(
                                fontFamily: 'pop',
                                color: textColor,
                              ),
                              errorStyle: TextStyle(
                                  fontFamily: 'pop', color: errorColor),
                              errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: errorColor)),
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white))),
                          onChanged: (text) {
                            name = text;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please Enter a Name");
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 15.0,right: 10.0,left: 10.0),
                child: Row(
                  children: [
                    Spacer(),
                    btnsss("Next", () { if(formKey.currentState!.validate()){
                      navScreen(city(name: name), context, false);
                    }}, mainColor, Colors.white)
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
