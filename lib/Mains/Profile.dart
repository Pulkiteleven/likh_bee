import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:likh_bee/Auth/OtpLogin.dart';
import 'package:likh_bee/GetStarted/name.dart';
import 'package:likh_bee/Mains/AllRequests.dart';
import 'package:likh_bee/Usefull/Avatars.dart';
import 'package:likh_bee/Usefull/Buttons.dart';
import 'package:likh_bee/Usefull/Colors.dart';
import 'package:likh_bee/Usefull/Functions.dart';
import 'package:shimmer/shimmer.dart';

import 'AllWork.dart';

late BuildContext mCtx;
late _profileState stateOfProfile;

class profile extends StatefulWidget {
  Map data;
  profile({Key? key,required this.data}) : super(key: key);

  @override
  State<profile> createState() {
    stateOfProfile = _profileState();
    return stateOfProfile;
  }
}

class _profileState extends State<profile> {
  bool isHide = false;
  List<Widget> myWorks = [];
  bool isMywork = true;
  User? user = FirebaseAuth.instance.currentUser;

  showit(String id) async{
    await showDialog(
      context: context,
      builder: (context) => Container(
        child: new AlertDialog(
          alignment: Alignment.bottomCenter,

          backgroundColor: yellowColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
          ),
          title: new Text('Are you sure?'),
          content: new Text('You Want to Remove this Work'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text('No'),
            ),
            TextButton(
              onPressed: () {
                FirebaseDatabase.instance.reference().child("works").child(id).remove()
                    .then((value) => {
                      getMyWork(),
                  Navigator.of(context).pop(false)
                });
              },
              child: new Text('Yes'),
            ),
          ],
        ),
      ),
    );
}

  @override
  void initState() {
    getMyWork();
  }

  getMyWork() async{
    setState((){
      isMywork = true;
    });
    var ref = await FirebaseDatabase.instance.reference().child('userWork').child(user!.uid);
    await ref.onValue.listen((event) async{
      if(event.snapshot.value != null){
        final data = event.snapshot.value as Map<dynamic,dynamic>;
        if(data != null){
          for(var x in data.keys){
            getWorkswithId(x);
          }
        }
      }
    });
  }

  getWorkswithId(String id) async{
    var ref = await FirebaseDatabase.instance.reference().child('works');
    final index = await ref.child(id).once();

    final data = index.snapshot.value as Map<dynamic,dynamic>;

    late String requests;

    if(data != null){
      print(data['date']);
      String date = getDate(data['date']);
      late var i;
      if(data['requests'] != null){
        var r = data['requests'] as Map<dynamic,dynamic>;
        requests = r.keys.toList().length.toString();
        i = workItems(data: data, userData: widget.data,date:date,requests: requests,req: true,);
      }
      else{
        i = workItems(data: data, userData: widget.data,date:date,);
      }
      setState((){
        myWorks.add(i);
        setState((){
          isMywork = false;
          isHide = false;
        });
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    mCtx = context;

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.0,),
                Row(
                  children: [
                    circleAvatar(index: widget.data['index'], radius: 50.0),
                    SizedBox(width: 3.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mainText(widget.data['name'], darktext, 15.0, FontWeight.bold, 1),
                        SizedBox(height: 5.0,),
                        mainText(widget.data['college'], textlight, 12.0, FontWeight.normal, 1),
                        SizedBox(height: 5.0,),
                        mainText(widget.data['city'], textlight, 12.0, FontWeight.normal, 1),
                        SizedBox(height: 5.0,),
                      ],
                    ),
                  ],
                ),
                SizedBox(height:15.0,),
                fullbtnsss("Edit Profile", () {navScreen(name(), context, false); }, mainColor, Colors.white),
                SizedBox(height: 15.0,),
                Row(
                  children: [
                    mainText("MyWorks", darktext, 20.0, FontWeight.bold, 1),
                    Spacer()
                  ],
                ),
                SizedBox(height: 10.0,),
                Visibility(
                    visible: isMywork,
                    child: Shimmer.fromColors(
                      baseColor: Colors.white,
                      highlightColor: shimmerColor,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(itemBuilder: (_, __) {
                          return shimmerItem();
                        },itemCount: 2,),
                      ),
                    )),

                Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: myWorks,
                      ),
                    ),
                    loaderss(isMywork, context)
                  ],
                ),


              ],
            ),
          ),
          loaderss(isHide, context)
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
  String requests;
  bool req;
  workItems({Key? key,required this.data,required this.userData,required this.date,this.requests = "No",this.req = false}) : super(key: key);

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
                    mainText(data['type'].toString(), lightColor, 12.0,
                        FontWeight.normal, 1),
                    Spacer(),
                    mainText("Price ₹" + data['price'].toString() + "/-",
                        mainColor, 15.0, FontWeight.normal, 1),
                  ],
                ),                SizedBox(height: 5.0,),
                Row(
                  children: [
                    btnsss("Delete", () { stateOfProfile.showit(data['id']);}, yellowColor, Colors.white),
                    Spacer(),
                    Visibility(
                        visible: req,
                        child: btnsss(requests + " Requests", () { navScreen(allRequests(data: data, date: date), context, false);}, lightColor, Colors.white)),
                    Visibility(
                        visible: !req,
                        child: btnsss(requests + " Requests", () {toaster("Sorry There are No Requests"); }, Colors.white, mainColor)),
                  ],
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }

}



