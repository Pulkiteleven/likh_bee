import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:likh_bee/FlutterAloo.dart';
import 'package:likh_bee/Mains/AllWork.dart';
import 'package:likh_bee/Mains/PostWork.dart';
import 'package:likh_bee/Mains/nayaAloo.dart';
import 'package:likh_bee/Usefull/Avatars.dart';
import 'package:likh_bee/Usefull/Buttons.dart';
import 'package:likh_bee/Usefull/Colors.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:likh_bee/Usefull/Functions.dart';
import 'package:likh_bee/Work/OneWork.dart';
import 'package:url_launcher/url_launcher.dart';


final _messangerKey = GlobalKey<ScaffoldMessengerState>();


class homes extends StatefulWidget {
  Map mainData;
  homes({Key? key,required this.mainData}) : super(key: key);

  @override
  State<homes> createState() => _homesState();
}

class _homesState extends State<homes> {
  bool isHide = false;
  List<Widget> feature = [];
  User? user = FirebaseAuth.instance.currentUser;
  List<String> categoryList = ['Assignment','Praticals','Engennering Drawing','Diagram'];
  String url = "";


  @override
  void initState() {
    getPreference();
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

  getPreference() async{
    var ref = FirebaseDatabase.instance.reference();
    final index = await ref.child('feature').once();

    var data = index.snapshot.value as Map<dynamic,dynamic>;
    if(data != null){
      for(var x in data.keys){
        getWorkswithId(x);
      }
    }
  }

  getWorkswithId(String id) async{
    var ref = await FirebaseDatabase.instance.reference().child('works');
    final index = await ref.child(id).once();

    final data = index.snapshot.value as Map<dynamic,dynamic>;
    print(data['date']);
    String date = getDate(data['date']);

    if(data != null){
      print(data['accept']);
      int p = 0;
      var a = {};
      var al = [];
      var r = {};
      var rl = [];
      bool show = false;
      if(data['accept'] != null) {
        a = data['accept'] as Map<dynamic, dynamic>;
        al = a.keys.toList();
      }
      else if(data['requests'] != null) {
        r = data['requests'] as Map<dynamic, dynamic>;
        rl = r.keys.toList();
      }
      if(al.contains(user!.uid)){
        p = 1;
        show = true;
      }
      else if(rl.contains(user!.uid)){
        p = 0;
        show = true;
      }
      if(data['from'] != user!.uid) {
        var i = workItems(data: data,
          userData: widget.mainData,
          date: date,
          r: p,
          show: show,);
        setState(() {
          feature.add(i);
          setState(() {
            isHide = false;
          });
        });
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _messangerKey,
      backgroundColor: bgColor,
      body: Stack(
        children: [
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height * 0.30,
          //   color: lightColor,
          //   child: ,
          // ),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 5.0,),
                    circleAvatar(index: widget.mainData['index'], radius: 25.0),
                    SizedBox(width: 5.0,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mainText(widget.mainData['name'], mainColor, 20.0, FontWeight.bold, 1),
                        mainText(widget.mainData['phone'], lightColor, 10.0, FontWeight.normal, 1),
                      ],
                    ),
                    Spacer(),
                    SizedBox(width: 5.0,),

                  ],
                ),

                // SizedBox(height: 15.0,),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     mainTextPop("PAY ", lightColor, 20.0, FontWeight.normal, 1),
                //     mainTextPop("WRITE ", mainColor, 20.0, FontWeight.normal, 1),
                //     mainTextPop("and ", lightText, 10.0, FontWeight.normal, 1),
                //     mainTextPop("HIRE ", acceptedColor, 20.0, FontWeight.normal, 1),
                //     Spacer(),
                //   ],
                // ),
                // SizedBox(height: 15.0,),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     btnshome("Likh Wa Lo", () { navScreen(alooDart(title: "Browse", bodies: allWork(data: widget.mainData)), context, false);}, mainColor, Colors.white),
                //     btnshome("Likh Lo", () { navScreen(alooDart(title: "Post", bodies: postWork(data: widget.mainData)), context, false);}, mainColor, Colors.white)
                //
                //   ],
                // ),
                SizedBox(height: 15.0,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      topSlidersItem(colors: item_four_top, title: "Assignments",iconColor: item_four_light, subTitle: "Assingment Likhwalo", callback: (){
                        navScreen(nayaAloo(title: categoryList[0],data: widget.mainData,), context, false);
                      }),
                      topSlidersItem(colors: item_three_top, title: "Praticals",iconColor: item_three_light, subTitle: "Praticals Likhwalo", callback: (){
                        navScreen(nayaAloo(title: categoryList[1],data: widget.mainData,), context, false);

                      }),
                      topSlidersItem(colors: item_one_top, title: "ED Sheets",iconColor: item_one_light, subTitle: "Ed Sheets BnwaLo", callback: (){
                        navScreen(nayaAloo(title: categoryList[2],data: widget.mainData,), context, false);
                      }),
                      topSlidersItem(colors: item_two_top, title: "Diagram",iconColor: item_two_light, subTitle: "Chalo Diagram bhi bnwa lo", callback: (){
                        navScreen(nayaAloo(title: categoryList[3],data: widget.mainData,), context, false);
                      }),
                      topSlidersItem(colors: item_four_top, title: "Website",iconColor: item_four_light, subTitle: "Our Website", callback: (){
                        _launchUrl(url);
                      }),
                    ],
                  ),
                ),
                SizedBox(height: 15.0,),
                Row(
                  children: [
                    mainText("Likhne Waale", darktext, 15.0, FontWeight.normal, 1),
                    Spacer(),
                    TextButton(onPressed: (){
                      navScreen(alooDart(title: "Browse", bodies: allWork(data: widget.mainData)),context,false);

                    }, child: mainText("View All", lightColor, 13.0, FontWeight.normal, 1),
                    ),
                    Icon(Icons.remove_red_eye_outlined,color: lightColor,),

                  ],
                ),
                SizedBox(height: 5.0,),
                SingleChildScrollView(
                  child: Column(
                    children: feature,
                  ),
                ),
                SizedBox(height: 15.0,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.40,
                      margin: EdgeInsets.only(right: 5.0),
                      child: GestureDetector(
                        onTap: (){
                          navScreen(alooDart(title: "Browse", bodies: postWork(data: widget.mainData)),context,false);
                        },
                        child: Card(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color:lightColor,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 30.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.add_box_outlined,color: mainColor,size: 50.0,
                                ),
                                SizedBox(height: 15.0,),
                                mainTextPop("LIKHO", Colors.white, 15.0, FontWeight.bold, 1)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width * 0.40,
                      margin: EdgeInsets.only(right: 5.0),
                      child: GestureDetector(
                        onTap: (){
                          navScreen(alooDart(title: "Browse", bodies: allWork(data: widget.mainData)),context,false);
                        },
                        child: Card(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color:lightColor,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 30.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.category_outlined,color: mainColor,size: 50.0,
                                ),
                                SizedBox(height: 15.0,),
                                mainTextPop("LIKHWAAO", Colors.white, 15.0, FontWeight.bold, 1)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),




              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String _url) async {
    print(url);
    if (!await launchUrl(Uri.parse(_url))) {
      throw 'Could not launch $_url';
    }
  }
}



class topSlidersItem extends StatefulWidget {
  Color colors;
  Color iconColor;
  String title;
  String subTitle;
  VoidCallback callback;
  topSlidersItem({Key? key,
    required this.colors,
    required this.iconColor,
    required this.title,required this.subTitle,
    required this.callback}) : super(key: key);

  @override
  State<topSlidersItem> createState() => _topSlidersItemState();
}

class _topSlidersItemState extends State<topSlidersItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: widget.callback,

      child: Container(
        width: MediaQuery.of(context).size.width * 0.90,
        height: MediaQuery.of(context).size.width * 0.40,
        child: Stack(
          fit: StackFit.loose,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.90,
              height: MediaQuery.of(context).size.width * 0.40,
              child: Card(
                // margin: EdgeInsets.only(right: 15.0,bottom: 5.0),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mainText(widget.title, mainColor, 25.0, FontWeight.bold, 1),
                        mainText(widget.subTitle, lightColor, 10.0, FontWeight.normal, 2)
                      ],
                    ),
                  )
              ),
            ),
            Container(
                alignment: Alignment.centerRight,
                child: Image.asset('Assets/likh.png',color: iconColor,width: 80.0,)),
          ],
        ),
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
  int r;
  bool show;

  workItems({Key? key,required this.data,required this.userData,required this.date,required this.r,required this.show}) : super(key: key);

  List ra = ['Requested','Accepted'];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
      child: GestureDetector(
        onTap: (){
          navScreen(oneWork(data: data), context, false);
        },
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)
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
                      mainText(data['name'], lightText, 13.0, FontWeight.bold, 1),
                      mainText(date, lightText, 10.0, FontWeight.normal, 1),
                    ],
                  ),
                  onTap: (){

                  },
                ),
                SizedBox(height: 10.0,),
                mainText(data['type'].toString(), mainColor, 12.0, FontWeight.normal, 1),
                mainTextFAQS(data['title'], darktext, 15.0, FontWeight.normal, 5),
                SizedBox(height: 5.0,),
                mainTextFAQS(data['desc'],lightText, 12.0, FontWeight.normal, 5),
                SizedBox(height: 5.0,),
                mainText("Price ₹" + data['price'].toString() + "/-", mainColor, 15.0, FontWeight.normal, 1),
                SizedBox(height: 5.0,),

                Visibility(
                    visible: show,
                    child: btnsss(ra[r], () { }, mainColor, Colors.white)),
              ],
            ),
          ),
        ),

      ),
    );
  }
}


