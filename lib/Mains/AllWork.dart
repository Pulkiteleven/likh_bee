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
import 'package:likh_bee/Work/OneWork.dart';
import 'package:shimmer/shimmer.dart';
import 'package:animations/animations.dart';


class allWork extends StatefulWidget {
  Map data;

  allWork({Key? key, required this.data}) : super(key: key);

  @override
  State<allWork> createState() => _allWorkState();
}

class _allWorkState extends State<allWork> {
  bool isHide = false;
  late BuildContext mCtx;
  List allWorks = [];
  List<Color> selectedC = [
    mainColor,
    mainColor,
    mainColor,
    mainColor
  ];
  List<Color> textC = [yellowColor,yellowColor,yellowColor,yellowColor];
  List<String> categoryList = [
    'Assignment',
    'Praticals',
    'Engennering Drawing',
    'Diagram'
  ];

  List<Widget> worksAll = [];
  List worksAllData = [];
  List postIds = [];

  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    getallWorks();
  }

  getallWorks() async {
    setState(() {
      isHide = true;
    });
    var ref = await FirebaseDatabase.instance.reference().child('collegeWork');
    await ref.child(widget.data['college']).onValue.listen((event) async {
      if (event.snapshot.value != null) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        print(data);
        if (data != null) {
          postIds = data.keys.toList();
          for (var x in data.keys) {
            getWorkswithId(x);
          }
        }
      }
    });
  }

  getWorkswithId(String id) async {
    var ref = await FirebaseDatabase.instance.reference().child('works');
    final index = await ref.child(id).once();

    final data = index.snapshot.value as Map<dynamic, dynamic>;
    print(data['date']);
    String date = getDate(data['date']);

    if (data != null) {
      print(data['accept']);
      int p = 0;
      var a = {};
      var al = [];
      var r = {};
      var rl = [];
      bool show = false;
      if (data['accept'] != null) {
        a = data['accept'] as Map<dynamic, dynamic>;
        al = a.keys.toList();
      } else if (data['requests'] != null) {
        r = data['requests'] as Map<dynamic, dynamic>;
        rl = r.keys.toList();
      }
      if (al.contains(user!.uid)) {
        p = 1;
        show = true;
      } else if (rl.contains(user!.uid)) {
        p = 0;
        show = true;
      }
      var i = workItems(
        data: data,
        userData: widget.data,
        date: date,
        r: p,
        show: show,
      );
      setState(() {
        if (data['from'] != user!.uid) {
          worksAllData.add(data);
          worksAll.add(i);
          setState(() {
            isHide = false;
          });
        }
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
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                mainText("Find the Work", darktext, 20.0, FontWeight.bold, 1),
                SizedBox(
                  height: 15.0,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      btnsss(categoryList[0], () {
                        changeColor(0);
                      }, selectedC[0], textC[0]),
                      SizedBox(
                        width: 3.0,
                      ),
                      btnsss(categoryList[1], () {
                        changeColor(1);
                      }, selectedC[1], textC[1]),
                      SizedBox(
                        width: 3.0,
                      ),
                      btnsss(categoryList[2], () {
                        changeColor(2);
                      }, selectedC[2], textC[2]),
                      SizedBox(
                        width: 3.0,
                      ),
                      btnsss(categoryList[3], () {
                        changeColor(3);
                      }, selectedC[3], textC[3]),
                      SizedBox(
                        width: 3.0,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
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
                SingleChildScrollView(
                    child: Column(
                  children: worksAll,
                ))
              ],
            ),
          ),
          // loaderss(isHide, context)
        ],
      ),
    );
  }

  changeColor(int index) {
    setState(() {
      selectedC = [mainColor,mainColor,mainColor,mainColor];
      textC = [yellowColor,yellowColor,yellowColor,yellowColor];
      String title = categoryList[index];
      selectedC[index] = yellowColor;
      textC[index] = mainColor;
      worksAll = [];
      for (var x in worksAllData) {
        var a = x as Map<dynamic, dynamic>;
        if (a['type'] == title) {
          String date = getDate(a['date']);
          int p = 0;
          var aa = {};
          var aal = [];
          var r = {};
          var rl = [];
          bool show = false;
          if (a['accept'] != null) {
            aa = a['accept'] as Map<dynamic, dynamic>;
            aal = aa.keys.toList();
          } else if (a['requests'] != null) {
            r = a['requests'] as Map<dynamic, dynamic>;
            rl = r.keys.toList();
          }
          if (aal.contains(user!.uid)) {
            p = 1;
            show = true;
          } else if (rl.contains(user!.uid)) {
            p = 0;
            show = true;
          }
          var i = workItems(
            data: a,
            userData: widget.data,
            date: date,
            r: p,
            show: show,
          );
          setState(() {
            worksAll.add(i);
          });
        }
      }
    });
  }
}

String getDate(String date) {
  var now = DateTime.now();
  var posted = DateTime.parse(date);
  var a = now.difference(posted);

  int days = a.inDays;
  int hours = a.inHours % 24;
  int minutes = a.inMinutes % 60;
  int seconds = a.inSeconds % 60;

  if (minutes == 0) {
    date = seconds.toString() + "s ago";
  } else if (hours == 0) {
    date = minutes.toString() + "m ago";
  } else if (days == 0) {
    date = hours.toString() + "h ago";
  } else if (days != 0) {
    date = days.toString() + "d ago";
  }
  return date;
}

class workItems extends StatelessWidget {
  Map userData;
  Map data;
  String date;
  int r;
  bool show;

  workItems(
      {Key? key,
      required this.data,
      required this.userData,
      required this.date,
      required this.r,
      required this.show})
      : super(key: key);

  List ra = ['Requested', 'Accepted'];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),

      child: GestureDetector(
        onTap: () {
          navScreen(oneWork(data: data), context, false);
        },
        child: Card(
          color: Colors.white,
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  minLeadingWidth: 0,
                  leading: circleAvatar(
                    index: data['index'],
                    radius: 20.0,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      mainText(
                          data['name'], textlight, 13.0, FontWeight.bold, 1),
                      mainText(date, textlight, 10.0, FontWeight.normal, 1),
                    ],
                  ),
                  onTap: () {},
                ),
                mainTextFAQS(
                    data['title'], darktext, 15.0, FontWeight.normal, 5),
                SizedBox(
                  height: 5.0,
                ),
                mainTextFAQS(
                    data['desc'], lightText, 12.0, FontWeight.normal, 5),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    mainText(data['type'].toString(), lightColor, 12.0,
                        FontWeight.normal, 1),
                    Spacer(),
                    mainText("Price ₹" + data['price'].toString() + "/-",
                        mainColor, 15.0, FontWeight.normal, 1),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Visibility(
                    visible: show,
                    child: btnsss(ra[r], () {}, mainColor, Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class shimmerItem extends StatelessWidget {
  const shimmerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
      child: Card(
        elevation: 5.0,
        color: Colors.white,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.all(0),
                minLeadingWidth: 0,
                leading: circleAvatar(
                  index: 2,
                  radius: 20.0,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    mainText("", textlight, 13.0, FontWeight.bold, 1),
                    mainText("", textlight, 10.0, FontWeight.normal, 1),
                  ],
                ),
                onTap: () {},
              ),
              mainTextFAQS("", darktext, 15.0, FontWeight.normal, 5),
              SizedBox(
                height: 5.0,
              ),
              mainTextFAQS("", lightText, 12.0, FontWeight.normal, 5),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  mainText("", lightColor, 12.0, FontWeight.normal, 1),
                  Spacer(),
                  mainText(" ", mainColor, 15.0, FontWeight.normal, 1),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


