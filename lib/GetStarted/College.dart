import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:likh_bee/GetStarted/Finishing.dart';
import 'package:likh_bee/GetStarted/What.dart';
import 'package:likh_bee/Usefull/Buttons.dart';
import 'package:likh_bee/Usefull/Colors.dart';
import 'package:likh_bee/Usefull/Functions.dart';

Map data = {};


class college extends StatefulWidget {
  String name;
  String city;
  college({Key? key,required this.name,required this.city}) : super(key: key);

  @override
  State<college> createState() => _collegeState();
}

class _collegeState extends State<college> {
  bool isHide = false;
  final formKey = GlobalKey<FormState>();
  String name = "";

  List<Widget> citiesItems = [];
  List<dynamic> citiesNames = [];



  @override
  void initState() {
    getIns();
    data = {
      'name':widget.name,
      'city':widget.city,
    };
  }

  getIns() async {
    setState((){
      isHide = true;
    });
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot =
    await firestore.collection('CCI').where("id", isEqualTo: widget.city.toLowerCase()).get();

    final allData = querySnapshot.docs.map((e) => e.data()).toList();
    var b = allData[0] as Map<String, dynamic>;
    print(b['all']);
    setState(() {
      citiesNames = b['all'];
      for (var x in citiesNames) {
        var a = listItems(title: x);
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
                        height: 70.0,
                      ),
                      Image.asset(
                        'Assets/college.png',
                        width: MediaQuery.of(context).size.width * 0.60,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      mainText("Select Your College", mainColor, 25.0,
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
                          labelText: 'Search Your College',
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
                                var b = listItems(title: x);
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
              lightyellowColor),
          backgroundColor:
          MaterialStateProperty.all<Color>(lightyellowColor),
          shape: MaterialStateProperty.all<
              RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(15.0),
                  side: BorderSide(color: lightyellowColor)))),
      onPressed: (){
        data['college'] = widget.title;
        navScreen(what(data: data), context, false);
      },
    );
  }
}

