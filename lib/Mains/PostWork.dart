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

final _messangerKey = GlobalKey<ScaffoldMessengerState>();


class postWork extends StatefulWidget {
  Map data;
  postWork({Key? key,required this.data}) : super(key: key);

  @override
  State<postWork> createState() => _postWorkState();
}

class _postWorkState extends State<postWork> {
  bool isHide = false;
  Widget cicleImage = Row();
  String title = "";
  String desc = "";
  int price = 0;
  bool isPost = false;
  bool Cselected = false;
  final formkey = GlobalKey<FormState>();
  String category = "";
  late BuildContext mCtx;

  List<Color> selectedC = [Colors.white,Colors.white,Colors.white,Colors.white];
  List<Color> textC = [mainColor,mainColor,mainColor,mainColor];
  List<String> categoryList = ['Assignment','Praticals','Engennering Drawing','Diagram'];

  FirebaseAuth user = FirebaseAuth.instance;

  @override
  void initState() {
    setState((){
      cicleImage = circleAvatar(index: widget.data['index'], radius: 30.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    mCtx = context;
    return Scaffold(
      backgroundColor: bgColor,
      key: _messangerKey,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  mainText("Post Your Work", darktext, 20.0, FontWeight.bold, 1),
                  SizedBox(height: 15.0,),
                  Row(
                    children: [
                      cicleImage,
                      SizedBox(width: 3.0,),
                      mainText(widget.data['name'], darktext, 15.0, FontWeight.bold, 1),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    minLines: 1,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(
                        color: lightText, fontSize: 20.0, fontFamily: 'pop'),
                    decoration: InputDecoration(
                      hintText: "Kyaa Karogee",
                      // labelText: "Add Title",
                      labelStyle: TextStyle(
                        color: lightText,
                        fontFamily: 'pop',
                        fontSize: 20.0,
                      ),
                      errorStyle: TextStyle(
                        color: errorColor,
                        fontFamily: 'pop',
                        fontSize: 15.0,
                      ),
                    ),
                    onChanged: (text) {
                      title = text;
                      print(text);
                      if (text.isEmpty) {
                        readyPost(false);
                      } else {
                        readyPost(true);
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return ("Please Enter a Title");
                      }
                    },
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    minLines: 1,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(
                        color: lightText, fontSize: 15.0, fontFamily: 'pop'),
                    decoration: InputDecoration(
                      hintText: "Kaise Karoge",
                      // labelText: "Add Title",
                      labelStyle: TextStyle(
                        color: lightText,
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
                      desc = text;
                      print(text);
                    },
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        color: lightText, fontSize: 15.0, fontFamily: 'pop'),
                    decoration: InputDecoration(
                      hintText: "Paise",
                      suffixIcon: Icon(Icons.currency_rupee_sharp,color: mainColor,),
                      // labelText: "Add Title",
                      labelStyle: TextStyle(
                        color: lightText,
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
                      price = int.parse(text);
                      print(text);
                    },
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return ("Please Enter a Price");
                      }
                    },
                  ),
                  SizedBox(height: 10.0,),
                  mainText("Work Type", lightText, 15.0, FontWeight.normal, 1),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        btnsss(categoryList[0], () {changeColor(0); }, selectedC[0], textC[0]),
                        SizedBox(width: 3.0,),
                        btnsss(categoryList[1], () {changeColor(1); }, selectedC[1], textC[1]),
                        SizedBox(width: 3.0,),
                        btnsss(categoryList[2], () {changeColor(2); }, selectedC[2], textC[2]),
                        SizedBox(width: 3.0,),
                        btnsss(categoryList[3], () {changeColor(3); }, selectedC[3], textC[3]),
                        SizedBox(width: 3.0,),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0,),

                  Visibility(
                      visible: isPost,
                      child: fullbtnsss("POST NOW", () { postNow();}, mainColor, Colors.white))
                ],
              ),
            ),
          ),
          loaderss(isHide, context)
        ],
      ),
    );
  }

  postNow() async{
    if(formkey.currentState!.validate()){
      if(Cselected){
        setState((){
          isHide = true;
        });
        String key = generateRandomString(15);
        Map<String,dynamic> Item = {
          'title':title,
          'desc':desc,
          'type':category,
          'price':price,
          'id':key,
          'date':DateTime.now().toString(),
          'from':user.currentUser!.uid,
          'name':widget.data['name'],
          'index':widget.data['index'],
        };

        Map<String,dynamic> mainItem = {key:Item};

        final ref = FirebaseDatabase.instance.reference();
        ref.child('works').update(mainItem).then((value) => {
          puttoCategory(category, key),
          print('done')
        });

      }
      else{
        print('hey');
        Snacker("Please Select a Work Type", _messangerKey);
      }
    }
    else{
      print('hello');
    }
  }

  puttoCategory(String cat,String id) async{
    Map<String,dynamic> item = {
      id:id
    };

    final ref = FirebaseDatabase.instance.reference();
    ref.child('category').child(cat).update(item).then((value) => {
      puttoUser(id)
    });


  }

  puttoUser(String id) async{
    Map<String,dynamic> item = {
      id:id
    };

    final ref = FirebaseDatabase.instance.reference();
    ref.child('userWork').child(user.currentUser!.uid).update(item).then((value) => {
      setState((){
        isHide =false;
        puttoCollege(id);
      })
    });
  }

  puttoCollege(String id) async{
    Map<String,dynamic> item = {
      id:id
    };

    final ref = FirebaseDatabase.instance.reference();
    ref.child('collegeWork').child(widget.data['college']).update(item).then((value) => {
      setState((){
        isHide =false;
        formkey.currentState!.reset();
        snacker("Work updated Succesfully", mCtx);
      })
    });
  }

  changeColor(int index){
    setState((){
      Cselected = true;
      selectedC = [Colors.white,Colors.white,Colors.white,Colors.white];
      textC = [mainColor,mainColor,mainColor,mainColor];

      selectedC[index] = mainColor;
      textC[index] = Colors.white;
      category = categoryList[index];
    });

  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  readyPost(bool a){
    setState((){
      isPost = a;
    });
  }
}
