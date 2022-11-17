import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:likh_bee/Auth/OtpLogin.dart';
import 'package:likh_bee/Chatee/Chat.dart';
import 'package:likh_bee/Usefull/Avatars.dart';
import 'package:likh_bee/Usefull/Buttons.dart';
import 'package:likh_bee/Usefull/Colors.dart';
import 'package:likh_bee/Usefull/Functions.dart';
import 'package:likh_bee/Work/OneWork.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';



late BuildContext mCCts;

class allRequests extends StatefulWidget {
  Map data;
  String date;
  allRequests({Key? key,required this.data,required this.date}) : super(key: key);

  @override
  State<allRequests> createState() => _allRequestsState();
}

class _allRequestsState extends State<allRequests> {
  bool isHide = false;
  List<Widget> ListRequests = [];


  @override
  void initState() {
    getRequests();
  }

  getRequests() async{
    setState((){
      isHide = true;
    });
    var r = widget.data['requests'] as Map<dynamic,dynamic>;
    for(var x in r.keys){
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      QuerySnapshot querySnapshot = await firestore.collection('user')
      .where("uid",isEqualTo: x).get();

      if(querySnapshot != null){
        final data = querySnapshot.docs.map((e) => e.data()).toList();
        if(data.length != 0){
          var d = data[0] as Map<String,dynamic>;
          String dates = DateFormat('EEE dd LLL').format(DateTime.parse(r[x]['date'])).toString();
          var i = requestItems(postData: widget.data, data: d, msg: r[x]['msg'],date: dates,);
          setState((){
            isHide = false;
            ListRequests.add(i);
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    mCCts = context;

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
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    minLeadingWidth: 0,
                    leading: circleAvatar(index: widget.data['index'],radius: 20.0,),
                    title:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mainText(widget.data['name'], lightText, 13.0, FontWeight.bold, 1),
                        mainText(widget.date, lightText, 10.0, FontWeight.normal, 1),
                      ],
                    ),
                    onTap: (){

                    },
                  ),
                  SizedBox(height: 10.0,),
                  mainText(widget.data['type'], mainColor, 12.0, FontWeight.normal, 1),
                  SizedBox(height: 5.0,),
                  mainTextFAQS(widget.data['title'], darktext, 15.0, FontWeight.normal, 5),
                  SizedBox(height: 5.0,),
                  mainTextFAQS(widget.data['desc'],lightText, 12.0, FontWeight.normal, 5),
                  SizedBox(height: 5.0,),
                  mainText("Price ₹" + widget.data['price'].toString() + "/-", mainColor, 15.0, FontWeight.normal, 1),
                  SizedBox(height: 10.0,),
                  mainText("All Requests", darktext, 20.0, FontWeight.normal, 1),
                  SizedBox(height: 10.0,),
                  Visibility(
                      visible: isHide,
                      child: Shimmer.fromColors(
                        baseColor: Colors.white,
                        highlightColor: shimmerColor,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(itemBuilder: (_, __) {
                            return shimmerRequst();
                          },itemCount: 4,),
                        ),
                      )),                  Column(
                    children: ListRequests,
                  ),
                ],
              ),
            ),
            // loaderss(isHide, context)
          ],
        ),
      ),
    );
  }
}

class requestItems extends StatefulWidget {
  Map postData;
  Map data;
  String msg;
  String date;
  requestItems({Key? key,required this.postData,required this.data,required this.msg,required this.date}) : super(key: key);

  @override
  State<requestItems> createState() => _requestItemsState();
}

class _requestItemsState extends State<requestItems> {
  String accept = "Accept";
  bool isAccept = false;
  String acceptMsg = "";
  final formkey = GlobalKey<FormState>();
  Color mains = Colors.white;
  Color text = mainColor;
  User? user = FirebaseAuth.instance.currentUser;
  bool accepted = false;
  bool acceptedTab = false;
  Color mainbg = Colors.white;

  @override
  void initState() {
    if(widget.postData['accept'] != null) {
      var a = widget.postData['accept'] as Map<dynamic, dynamic>;
      var al = a.keys.toList();
      print(al);
      if (al.contains(widget.data['uid'])) {
        setState(() {
          setState(() {
            accepted = true;
            mainbg = acceptedColor;
            print("hello $accepted");
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
      child: GestureDetector(
        onTap: (){
          // navScreen(oneWork(data: data), context, false);
        },
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  minLeadingWidth: 0,
                  leading: circleAvatar(index: widget.data['index'],radius: 20.0,),
                  title:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      mainText(widget.data['name'], textlight, 13.0, FontWeight.bold, 1),
                    ],
                  ),
                  trailing: Column(
                    children: [
                      Visibility(
                        visible:!accepted,
                        child: btnsss(accept, () { setState((){
                          isAccept = !isAccept;
                        });
                          }, mains, text),
                      ),
                      Visibility(
                          visible: accepted,
                          child: btnsss("Working", () {
                      }, mainColor, Colors.white))
                    ],
                  ),
                  onTap: (){

                  },
                ),
                Visibility(
                  visible:accepted,
                  child: Row(
                    children: [
                      btnsss("Chat", () {
                        navScreen(chat(data: widget.data), context, false);
                      }, yellowColor, Colors.white),
                    ],
                  ),
                ),

                SizedBox(height: 5.0,),
                mainTextFAQS("msg : " + widget.msg, textlight, 13.0, FontWeight.normal, 5),
                SizedBox(height: 5.0,),
                mainTextFAQS("Wanted By : " + widget.date,yellowColor, 13.0, FontWeight.normal, 5),

                Visibility(
                    visible: isAccept,
                    child: Form(
                      key: formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            minLines: 1,
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            style: TextStyle(
                                color: textlight,
                                fontSize: 12.0,
                                fontFamily: 'pop'),
                            decoration: InputDecoration(
                              hintText: "Enter Your Accept Message",
                              // labelText: "Add Title",
                              labelStyle: TextStyle(
                                color: textlight,
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
                              acceptMsg = text;
                              print(text);
                            },
                            validator: (value) {
                              if (value!.isEmpty || value == null) {
                                return ("Please Enter an Message");
                              }
                            },
                          ),
                          SizedBox(height: 5.0,),
                          mainTextFAQS("This will Share Your Phone with Client", mainColor, 13.0, FontWeight.normal, 2),
                          SizedBox(height: 5.0,),
                          Row(children: [
                            Spacer(),
                            btnsss("Accept it", () { acceptRequest();}, mainColor,Colors.white)
                          ],),

                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),

      ),
    );
  }

  acceptRequest() async{
    User? user = await FirebaseAuth.instance.currentUser;
    Map<String,dynamic> item = {widget.data['uid']:{'msg':acceptMsg,'phone':user!.phoneNumber,}};
    var ref = FirebaseDatabase.instance.reference();
    ref.child('works').child(widget.postData['id']).child('accept').update(item).then((value) =>
    {
      setState((){
        accepted = true;
        isAccept = !isAccept;
        mainbg = acceptedColor;
      })

    });
  }
}

class shimmerRequst extends StatelessWidget {
  const shimmerRequst({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
      child: GestureDetector(
        onTap: (){
          // navScreen(oneWork(data: data), context, false);
        },
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  minLeadingWidth: 0,
                  leading: circleAvatar(index: 2,radius: 20.0,),
                  title:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      mainText("", lightText, 13.0, FontWeight.bold, 1),
                    ],
                  ),
                  trailing: Column(
                    children: [],
                  ),
                  onTap: (){

                  },
                ),
                SizedBox(height: 5.0,),

                SizedBox(height: 5.0,),
                mainTextFAQS("", textlight, 13.0, FontWeight.normal, 5),
                SizedBox(height: 5.0,),
              ],
            ),
          ),
        ),

      ),
    );

  }
}


