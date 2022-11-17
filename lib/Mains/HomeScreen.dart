import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:likh_bee/Mains/AllWork.dart';
import 'package:likh_bee/Mains/MyRequests.dart';
import 'package:likh_bee/Mains/PostWork.dart';
import 'package:likh_bee/Mains/Profile.dart';
import 'package:likh_bee/Mains/homes.dart';
import 'package:likh_bee/Menu/menu.dart';
import 'package:likh_bee/Usefull/Avatars.dart';
import 'package:likh_bee/Usefull/Colors.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:likh_bee/Usefull/Functions.dart';


final _messangerKey = GlobalKey<ScaffoldMessengerState>();

final GlobalKey<ScaffoldState> _key = GlobalKey();
// Create a key

class homeScreen extends StatefulWidget {
  Map<String, dynamic> allData;

  homeScreen({Key? key,required this.allData})
      : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  String name = "";
  bool isHide = false;
  int currentIndex = 0;
  Map<dynamic,dynamic> mainData = {};

  List bottomItems = [];

  Widget navButton = Icon(
    Icons.sort,
    size: 25.0,
    color: mainColor,
  );


  @override
  void initState() {
    // getName();

    setState(() {
      name = widget.allData['name'];
    });

    setState((){
      bottomItems = [
        homes(mainData: widget.allData),
        allWork(data: widget.allData),
        postWork(data: widget.allData),
        myRequests(data: widget.allData),
        profile(data: widget.allData),
      ];
    });

  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        alignment: Alignment.bottomCenter,
        backgroundColor: yellowColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          key: _key,
          backgroundColor: bgColor,
          appBar:AppBar(
            backgroundColor:Colors.white,
            leadingWidth: 150.0,

            leading: Column(
              children: [
                Spacer(),
                Row(
                  children: [
                    SizedBox(width: 10.0,),
                    Image.asset('Assets/nlb.png',width: 80.0,),
                    // mainTextPop("LikhBee", mainColor, 15.0, FontWeight.normal, 1),
                  ],
                ),
                Spacer(),

              ],
            ),

            actions: [
              IconButton(onPressed: (){

              }, icon: IconButton(
                onPressed: (){
                  navScreen(menu(), context, false);
                },

                icon: Icon(Icons.sort,color: mainColor,),
              ))
            ],
          ),
          bottomNavigationBar: FlashyTabBar(
            backgroundColor: Colors.white,
            onItemSelected: (int val) => setState(() => currentIndex = val),
            selectedIndex: currentIndex,
            items: [
              FlashyTabBarItem(
                icon: Icon(
                  Icons.home,
                  color: mainColor,
                ),
                title:
                mainTextLeft("Home", mainColor, 15.0, FontWeight.normal, 1),
              ),
              FlashyTabBarItem(
                icon: Icon(
                  Icons.category,
                  color: mainColor,
                ),
                title: mainTextLeft(
                    "Explore", mainColor, 15.0, FontWeight.normal, 1),
              ),
              FlashyTabBarItem(
                icon: Icon(
                  Icons.add_box_outlined,
                  color: mainColor,
                ),
                title: mainTextLeft(
                    "Post", mainColor, 15.0, FontWeight.normal, 1),
              ),
              FlashyTabBarItem(
                icon: Icon(
                  Icons.request_quote_outlined,
                  color: mainColor,
                ),
                title: mainTextLeft(
                    "Requests", mainColor, 15.0, FontWeight.normal, 1),
              ),
              FlashyTabBarItem(
                icon: Icon(
                  Icons.account_circle,
                  color: mainColor,
                ),
                title: mainTextLeft(
                    "Profile", mainColor, 15.0, FontWeight.normal, 1),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.only(bottom: 0.0),
           child: bottomItems.elementAt(currentIndex),)
        ),
      ),
    );
  }



}
