import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:likh_bee/Auth/LoginWithMobile.dart';
import 'package:likh_bee/Backend/backend.dart';
import 'package:likh_bee/Chatee/Chat.dart';
import 'package:likh_bee/GetStarted/Avatar.dart';
import 'package:likh_bee/Usefull/Colors.dart';
import 'package:likh_bee/Usefull/Functions.dart';

import 'Auth/OtpLogin.dart';
import 'GetStarted/name.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    // home: enterOtp(number: "3335355",vId: "5454545",),
    // home:name()
    // home:otpLogin(),
    home:MpApp()
    // home:chat()
    // home:avatar(data: {})
  ));


}

class MpApp extends StatefulWidget {
  const MpApp({Key? key}) : super(key: key);

  @override
  State<MpApp> createState() => _MpAppState();
}

class _MpAppState extends State<MpApp> {



  @override
  void initState() {
    check();
  }

  check() async{
    FirebaseAuth user =  await FirebaseAuth.instance;
    if(user.currentUser != null){
      checker(context);
    }
    else{
      navScreen(otpLogin(), context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: mainColor,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('Assets/nlb.png',width: 200.0
                ),
                Row(
                  children: [
                    Spacer(),
                    mainTextPop("", Colors.white, 30.0, FontWeight.normal,1),
                    Spacer(),
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              alignment: Alignment.bottomCenter,
              child:mainTextPop('PAY, WRITE and HIRE',yellowColor, 18.0, FontWeight.normal,1),

            )
          ],
        ),
      ),
    );
  }
}

Widget gola(double r){
  return CircleAvatar(
    radius: r,
    backgroundColor: mainColor,
  );
}



