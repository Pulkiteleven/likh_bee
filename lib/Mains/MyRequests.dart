import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:likh_bee/Auth/OtpLogin.dart';
import 'package:likh_bee/Mains/AllWork.dart';
import 'package:likh_bee/Mains/RequestAccepted.dart';
import 'package:likh_bee/Usefull/Avatars.dart';
import 'package:likh_bee/Usefull/Buttons.dart';
import 'package:likh_bee/Usefull/Colors.dart';
import 'package:likh_bee/Usefull/Functions.dart';
import 'package:likh_bee/Work/OneWork.dart';
import 'package:shimmer/shimmer.dart';


class myRequests extends StatefulWidget {
  Map data;
  myRequests({Key? key,required this.data}) : super(key: key);

  @override
  State<myRequests> createState() => _myRequestsState();
}

class _myRequestsState extends State<myRequests> {
  bool isHide = false;
  List<workItems> allRequets = [];
  List<workItems> stockallRequets = [];
  User? user = FirebaseAuth.instance.currentUser;

  List<Color> ARcolor = [mainColor,yellowColor];
  int Acolor = 0;
  int Rcolor = 0;
  @override
  void initState() {
    getMyRequests();
  }

  getMyRequests() async{
    setState((){
      isHide = true;
    });
    var ref = await FirebaseDatabase.instance.reference().child('userRequests').child(user!.uid);
    await ref.onValue.listen((event) async{
      if(event.snapshot.value != null){
        final data = event.snapshot.value as Map<dynamic,dynamic>;
        if(data != null){
          for(var x in data.keys){
            getWorkswithId(x,data[x]['msg']);
          }
        }
      }
    });
  }

  getWorkswithId(String id,String msg) async{
    var ref = await FirebaseDatabase.instance.reference().child('works');
    final index = await ref.child(id).once();

    final data = index.snapshot.value as Map<dynamic,dynamic>;
    print(data['date']);
    String date = getDate(data['date']);
    late String requests;

    if(data != null){
      var a = {};
      var al = [];
      var r = {};
      var rl = [];
      bool show = false;
      if(data['accept'] != null) {
        a = data['accept'] as Map<dynamic, dynamic>;
        al = a.keys.toList();
      }
      if(al.contains(user!.uid)){
        show = true;
      }
      var i = workItems(data: data, userData: widget.data,date:date,msg: msg,show: show,);

      setState((){
        allRequets.add(i);
        stockallRequets.add(i);
        setState((){
          isHide = false;
        });
      });
    }
  }

  getRA(int a){
    if(a == 0){
      allRequets = [];
      for(var x in stockallRequets){
        if(x.show){
          setState((){
            allRequets.add(x);
            Acolor = 1;
            Rcolor = 0;
          });
        }
      }
    }
    else{
      allRequets = [];
      for(var x in stockallRequets){
        if(!x.show){
          setState((){
            allRequets.add(x);
            Rcolor = 1;
            Acolor = 0;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                mainText("My Requests", darktext, 20.0, FontWeight.bold, 1),
                SizedBox(height: 15.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    btnsss("Requested", () {getRA(1);}, ARcolor[Rcolor],Colors.white),
                    btnsss("Accepted", () { getRA(0);}, ARcolor[Acolor],Colors.white),
                  ],
                ),
                SizedBox(height: 10.0,),
                Visibility(
                    visible: isHide,
                    child: Shimmer.fromColors(
                      baseColor: Colors.white,
                      highlightColor: shimmerColor,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(itemBuilder: (_, __) {
                          return shimmerItem();
                        },itemCount: 3,),
                      ),
                    )),

                Column(
                  children: allRequets,
                )
              ],
            ),
          ),
          // loaderss(isHide, context)
        ],
      ),
    );
  }
}

String getDate(String date){
  var now = DateTime.now();
  var posted = DateTime.parse(date);
  var a = now.difference(posted);

  int days = a.inDays;
  int hours = a.inHours % 24;
  int minutes = a.inMinutes % 60;
  int seconds = a.inSeconds % 60;

  if(minutes == 0){
    date = seconds.toString() + "s ago";
  }
  else if(hours == 0){
    date = minutes.toString() + "m ago";
  }
  else if(days == 0){
    date = hours.toString() + "h ago";
  }
  else if(days != 0){
    date = days.toString() + "d ago";
  }
  return date;
}


class workItems extends StatelessWidget {
  Map userData;
  Map data;
  String date;
  String msg;
  bool show;
  workItems({Key? key,required this.data,required this.userData,required this.date,required this.msg,required this.show}) : super(key: key);

  bool showmsg = false;
  bool accepted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
      child: GestureDetector(
        onTap: (){
          // navScreen(oneWork(data: data), context, false);
        },
        child: Card(
          elevation: 5.0,

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
                  leading: circleAvatar(index: data['index'],radius: 20.0,),
                  title:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      mainText(data['name'], textlight, 13.0, FontWeight.bold, 1),
                      mainText(date, textlight, 10.0, FontWeight.normal, 1),
                    ],
                  ),
                  onTap: (){

                  },
                ),
                mainTextFAQS(data['title'], darktext, 15.0, FontWeight.normal, 5),
                SizedBox(height: 5.0,),
                Row(
                  children: [
                    mainText(data['type'], mainColor, 12.0, FontWeight.normal, 1),
                    Spacer(),
                    mainText("Price ???" + data['price'].toString() + "/-", mainColor, 15.0, FontWeight.normal, 1),
                  ],
                ),
                SizedBox(height: 5.0,),
                mainTextFAQS(msg, lightText, 15.0, FontWeight.normal, 5),
                Visibility(
                    visible: !show,
                    child: btnsss("Requested", () { }, Colors.white, mainColor)),
                Visibility(
                    visible: show,
                    child: btnsss("Accepted", () { navScreen(requestAccepted(data: data), context, false);}, mainColor, Colors.white)),
              ],
            ),
          ),
        ),

      ),
    );
  }



}


