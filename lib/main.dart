import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:likh_bee/Auth/LoginWithMobile.dart';
import 'package:likh_bee/Backend/backend.dart';
import 'package:likh_bee/GetStarted/Avatar.dart';
import 'package:likh_bee/Usefull/Colors.dart';
import 'package:likh_bee/Usefull/Functions.dart';

import 'GetStarted/name.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    // home: enterOtp(number: "3335355",vId: "5454545",),
    // home:name()
    // home:otpLogin(),
    home:MpApp()
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
        backgroundColor: darkColor,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('Assets/likh.png',width: 60.0,color: Colors.white,),
                Row(
                  children: [
                    Spacer(),
                    mainTextPop("LikhBee", Colors.white, 30.0, FontWeight.normal,1),
                    Spacer(),
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              alignment: Alignment.bottomCenter,
              child:mainText('PAY, WRITE and HIRE',Colors.white, 18.0, FontWeight.normal,1),

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



