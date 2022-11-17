import 'package:flutter/material.dart';

import '../Usefull/Colors.dart';
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


class nayaAloo extends StatefulWidget {
  String title;
  Map data;
  nayaAloo({Key? key, required this.title,required this.data})
      : super(key: key);

  @override
  State<nayaAloo> createState() => _nayaAlooState();
}

class _nayaAlooState extends State<nayaAloo> {
  bool isHide = false;
  List<Widget> works = [];
  User? user = FirebaseAuth.instance.currentUser;


  @override
  void initState() {
    getPreference();
  }

  getPreference() async{
    setState((){
      isHide = true;
    });
    var ref = FirebaseDatabase.instance.reference();
    final index = await ref.child('category').child(widget.title).once();

    var data = index.snapshot.value as Map<dynamic,dynamic>;
    if(data != null){
      for(var x in data.keys){
        getCollege(x);
      }
    }
  }
  
  getCollege(String id) async{
    var ref = FirebaseDatabase.instance.reference();
    final index = await ref.child('collegeWork').child(widget.data['college']).child(id).once();
    print("Hello" + index.snapshot.value.toString());
    if(index.snapshot.value != null){
      getWorkswithId(id);
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
      var i = workItems(data: data, userData: widget.data,date:date,r: p,show: show,);
      setState((){
        works.add(i);
        setState((){
          isHide = false;
        });
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              leading:  FloatingActionButton(
                mini: true,
                elevation: 0.0,
                backgroundColor: Colors.white,
                child: Icon(Icons.close,color: mainColor,),
                onPressed: () {
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
                      mainText(widget.title, darktext, 20.0, FontWeight.bold, 1),
                      SizedBox(height: 15.0,),
                      Column(children: works,)
                    ],
                  ),
                ),
                loaderss(isHide, context)
              ],
            )));
  }
}
