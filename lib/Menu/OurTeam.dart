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
import 'package:url_launcher/url_launcher.dart';



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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                      child: Image.asset('Assets/inertia.jpg',width: 100.0,)),
                  mainText("The App is Developed by team Inert!a", darktext, 10.0, FontWeight.normal, 1),
                 SizedBox(height: 30.0,),
                  mainText("Me!", mainColor, 15.0, FontWeight.bold, 1),

              SizedBox(height: 10.0,),
                  ClipOval(
                      child: Image.asset('Assets/pulkit.jpg',width: 80.0,)),
                  SizedBox(height: 5.0,),
                  mainText("Pulkit Dubey", darktext, 20.0, FontWeight.bold, 1),
                  SizedBox(height: 5.0,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(onTap: (){
                        _launchUrl("https://www.linkedin.com/in/pulkit-dubey-75b703224/");
                      },
                        child: Image.asset('Assets/linkedin.png',width: 30.0,),),
                      SizedBox(width: 20.0,),
                      GestureDetector(onTap: (){
                        _launchUrl("https://www.instagram.com/kylo_ren__20/");
                      },
                        child: Image.asset('Assets/insta.png',width: 30.0,),),
                    ],
                  )
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         card(name: "Assets/pulkit.jpg", title: "Pulkit Dubey", pos: "App", url: "https://www.linkedin.com/in/pulkit-dubey-75b703224/"),
              // ]
              //     ),
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

class card extends StatelessWidget {
  String name;
  String title;
  String pos;
  String url;
  card({Key? key,required this.name,required this.title,required this.pos,required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
      width: MediaQuery.of(context).size.width - 80,
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40.0,
                child: ClipOval(
                    child: Image.asset(name,fit: BoxFit.cover,)),
              ),
              SizedBox(width: 5.0,),
              Column(
                children: [
                  mainText(title, darktext, 20.0, FontWeight.bold,1),
                  SizedBox(height: 10.0,),
                  Row(
                    children: [
                      GestureDetector(onTap: (){
                        _launchUrl(url);
                      },
                      child: Image.asset('Assets/linkedin.png',width: 30.0,),),
                      SizedBox(width: 20.0,),
                      GestureDetector(onTap: (){
                        _launchUrl("https://www.instagram.com/kylo_ren__20/");
                      },
                      child: Image.asset('Assets/insta.png',width: 30.0,),),
                    ],
                  )
                ],
              ),
              SizedBox(height: 3.0,),

            ],
          ),
        ),
      ),
    );
  }
}


Future<void> _launchUrl(String _url) async {
print(_url);
if (!await launchUrl(Uri.parse(_url))) {
throw 'Could not launch $_url';
}
}

