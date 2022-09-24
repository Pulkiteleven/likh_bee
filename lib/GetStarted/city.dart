import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:likh_bee/GetStarted/Finishing.dart';
import 'package:likh_bee/Usefull/Buttons.dart';
import 'package:likh_bee/Usefull/Colors.dart';
import 'package:likh_bee/Usefull/Functions.dart';

import 'College.dart';

String name = "";
class city extends StatefulWidget {
  String name;
  city({Key? key,required this.name}) : super(key: key);

  @override
  State<city> createState() => _cityState();
}

class _cityState extends State<city> {
  bool isHide = false;
  final formKey = GlobalKey<FormState>();
  String name = "";

  List<Widget> citiesItems = [];
  List<dynamic> citiesNames = [];

  @override
  void initState() {
    getCities();
    name = widget.name;
  }

  getCities() async {
    setState((){
      isHide = true;
    });
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot =
    await firestore.collection('CCI').where("id", isEqualTo: "city").get();

    final allData = querySnapshot.docs.map((e) => e.data()).toList();
    var b = allData[0] as Map<String, dynamic>;
    print(b['all']);
    setState(() {
      citiesNames = b['all'];
      for (var x in citiesNames) {
        var a = listItems(title:x,name: widget.name,);
        setState(() {
          citiesItems.add(a);
          isHide = false;
        });
      }
    });
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 70.0,
                      ),
                      Image.asset(
                        'Assets/city.png',
                        width: MediaQuery.of(context).size.width * 0.60,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      mainText("Select Your City", mainColor, 25.0,
                          FontWeight.normal, 1),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        cursorColor: lightText,
                        style: TextStyle(fontFamily: 'ral', color: textColor),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {},
                          ),
                          labelText: 'Search Your City',
                          labelStyle: TextStyle(
                            fontFamily: 'pop',
                            color: textColor,
                          ),
                          errorStyle:
                          TextStyle(fontFamily: 'pop', color: errorColor),
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: errorColor)),
                          disabledBorder: InputBorder.none,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(width: 0.3, color: Colors.white)),
                        ),
                        onChanged: (text) {
                          String search = "";
                          search = text;
                          var a = citiesNames;
                          citiesItems = [];
                          for (var x in a) {
                            if (x.toUpperCase().contains(text.toUpperCase())) {
                              setState(() {
                                var b = listItems(title: x,name: widget.name,);
                                citiesItems.add(b);
                              });
                            }
                          }
                        },
                      ),

                      Container(
                        child: SingleChildScrollView(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 2.0,
                            runSpacing: 2.0,
                            children: citiesItems,
                          ),
                        ),
                      ),
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
  String name;
  listItems({Key? key,required this.title,required this.name}) : super(key: key);

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
        navScreen(college(name: widget.name, city:widget.title), context, false);
      },
    );
  }
}

