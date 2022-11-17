import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:likh_bee/GetStarted/Finishing.dart';
import 'package:likh_bee/Usefull/Buttons.dart';
import 'package:likh_bee/Usefull/Colors.dart';
import 'package:likh_bee/Usefull/Functions.dart';


late _avatarState stateOfAvatars;

class avatar extends StatefulWidget {
  Map data;

  avatar({Key? key, required this.data}) : super(key: key);

  @override
  State<avatar> createState() {
    stateOfAvatars = _avatarState();
    return stateOfAvatars;
  }
}

class _avatarState extends State<avatar> {
  bool isHide = false;
  final formKey = GlobalKey<FormState>();
  String imagesS = "";
  int imagesIndex = 0;
  List<Widget> citiesItems = [];
  List<dynamic> citiesNames = [];
  List<String> avartsTitle = [
    'avatars/1.jpg',
    'avatars/2.jpg',
    'avatars/3.jpg',
    'avatars/4.jpg',
    'avatars/5.jpg',
    'avatars/6.jpg',
    'avatars/7.jpg',
    'avatars/8.jpg',
    'avatars/9.jpg',
    'avatars/10.jpg',
    'avatars/11.jpg',
    'avatars/12.jpg',
  ];

  @override
  void initState() {
    setState((){
      imagesS = avartsTitle[0];
    });
    print(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: yellowColor,
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
                        height: 100.0,
                      ),
                      CircleAvatar(
                        radius: 70.0,
                        backgroundColor: bgColor,
                        child: ClipOval(
                          child: Image.asset(
                            avartsTitle[imagesIndex],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),

                      mainText("Choose Your Avatar", mainColor, 25.0,
                          FontWeight.normal, 1),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          circles(name:avartsTitle[0], index: 0),
                          circles(name:avartsTitle[1], index: 1),
                          circles(name:avartsTitle[2], index: 2),
                        ],
                      ),
                      SizedBox(height: 10.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          circles(name:avartsTitle[3], index: 3),
                          circles(name:avartsTitle[4], index: 4),
                          circles(name:avartsTitle[5], index: 5),

                        ],
                      ),
                      SizedBox(height: 10.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          circles(name:avartsTitle[6], index: 6),
                          circles(name:avartsTitle[7], index: 7),
                          circles(name:avartsTitle[8], index: 8),

                        ],
                      ),
                      SizedBox(height: 10.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          circles(name:avartsTitle[9], index: 9),
                          circles(name:avartsTitle[10], index: 10),
                          circles(name:avartsTitle[11], index: 11),

                        ],
                      ),

                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 15.0, right: 10.0, left: 10.0),
                child: Row(
                  children: [
                    Spacer(),
                    btnsss("Finish", () {
                      widget.data['aindex'] = imagesIndex;
                      navScreen(Finishing(data: widget.data), context, false);}, mainColor, Colors.white),
                    Spacer()
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

class circles extends StatelessWidget {
  String name;
  int index;
  circles({Key? key,required this.name,required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CircleAvatar(
        radius: 40.0,
        backgroundColor: bgColor,
        child: Padding(
          padding: EdgeInsets.all(1.0),
          child: ClipOval(
            child: Image.asset(
              name,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      onTap: (){
        stateOfAvatars.setState((){
          stateOfAvatars.imagesIndex = index;
        });
      },
    );
  }
}


Widget circleImg(String name,int index) {
  return GestureDetector(
      child: CircleAvatar(
    radius: 30.0,
    backgroundColor: lightColor,
    child: Padding(
      padding: EdgeInsets.all(1.0),
      child: ClipOval(
        child: Image.asset(
          name,
          fit: BoxFit.cover,
        ),
      ),
    ),
  ),
  onTap: (){
        stateOfAvatars.setState((){
          stateOfAvatars.imagesIndex = index;
        });
  },
  );
}

class listItems extends StatefulWidget {
  String title;

  
  listItems({Key? key, required this.title}) : super(key: key);

  @override
  State<listItems> createState() => _listItemsState();
}

class _listItemsState extends State<listItems> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
        child: mainText(widget.title, mainColor, 13.0, FontWeight.normal, 1),
      ),
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: Colors.white)))),
      onPressed: () {},
    );
  }
}
