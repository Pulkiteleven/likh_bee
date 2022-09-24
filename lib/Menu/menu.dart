import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:likh_bee/Auth/LoginWithMobile.dart';
import 'package:likh_bee/FlutterAloo.dart';
import 'package:likh_bee/Mains/AllWork.dart';
import 'package:likh_bee/Mains/PostWork.dart';
import 'package:likh_bee/Mains/nayaAloo.dart';
import 'package:likh_bee/Menu/About%20us.dart';
import 'package:likh_bee/Menu/OurTeam.dart';
import 'package:likh_bee/Menu/Query.dart';
import 'package:likh_bee/Usefull/Avatars.dart';
import 'package:likh_bee/Usefull/Buttons.dart';
import 'package:likh_bee/Usefull/Colors.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:likh_bee/Usefull/Functions.dart';
import 'package:likh_bee/Work/OneWork.dart';
import 'package:url_launcher/url_launcher.dart';



class menu extends StatefulWidget {

  const menu({Key? key}) : super(key: key);

  @override
  State<menu> createState() => _menuState();
}

class _menuState extends State<menu> {
  bool isHide = false;
  bool logouts = false;
  String url = "";


  @override
  void initState() {
    getUrl();
  }

  getUrl() async{
    var ref = FirebaseDatabase.instance.reference();
    var index = await ref.child("url").once();
    var a = index.snapshot.value as String;
    setState((){
      url = a;
    });
  }

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
                  mainText("Menu", darktext, 20.0, FontWeight.bold, 1),

                  SizedBox(height: 15.0,),
                  ListTile(
                    leading: Icon(
                      Icons.info_outline,
                      color: textlight,
                    ),
                    title: mainText("About US", textlight, 15.0, FontWeight.normal, 1),
                    onTap: (){
                      navScreen(aboutUs(), context, false);
                    },
                  ),
                  SizedBox(height: 10.0,),

                  ListTile(
                    leading: Icon(
                      Icons.people_alt_outlined,
                      color: textlight,
                    ),
                    title: mainText("Our Team", textlight, 15.0, FontWeight.normal, 1),
                    onTap: (){
                      navScreen(OurTeam(), context, false);

                    },
                  ),
                  SizedBox(height: 10.0,),

                  ListTile(
                    leading: Icon(
                      Icons.web,
                      color: textlight,
                    ),
                    title: mainText("Our Website", textlight, 15.0, FontWeight.normal, 1),
                    onTap: (){
                      _launchUrl(url);
                    },
                  ),
                  SizedBox(height: 10.0,),

                  ListTile(
                    leading: Icon(
                      Icons.query_builder,
                      color: textlight,
                    ),
                    title: mainText("Raise a Query", textlight, 15.0, FontWeight.normal, 1),
                    onTap: (){
                      navScreen(query(), context, false);
                    },
                  ),


                  SizedBox(height: 10.0,),

                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: textlight,
                    ),
                    title: mainText("Logout", textlight, 15.0, FontWeight.normal, 1),
                    onTap: (){
                      FirebaseAuth.instance.signOut().then((value) => {
                        navScreen(otpLogin(), context, true),
                      });
                    },
                  ),
                  SizedBox(height: 10.0,),

                ],
              ),
            ),

            loaderss(isHide, context)
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String _url) async {
    print(url);
    if (!await launchUrl(Uri.parse(_url))) {
      throw 'Could not launch $_url';
    }
  }

  Dialogs (BuildContext context,String title,Widget content,VoidCallback callback){
    showDialog(context: context,
        builder: (ctx)=>AlertDialog(
          title: mainText(
              title,darktext, 15.0, FontWeight.normal, 1),
          content: SingleChildScrollView(
            child: content,

          ),
          actions: <Widget>[
            TextButton(onPressed: callback,
                child: mainText("Okay", mainColor, 10.0, FontWeight.normal, 1))
          ],
        ));
  }
}
