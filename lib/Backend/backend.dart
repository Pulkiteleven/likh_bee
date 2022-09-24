import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:likh_bee/Mains/HomeScreen.dart';
import 'package:likh_bee/Usefull/Colors.dart';
import 'package:likh_bee/Usefull/Functions.dart';

import '../GetStarted/name.dart';

checker(BuildContext context) async{
  User? user = await FirebaseAuth.instance.currentUser;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot querySnapshot = await firestore.collection('user')
  .where("uid",isEqualTo: user!.uid).get();

  if (querySnapshot != null){
    final allData = querySnapshot.docs.map((e) => e.data()).toList();
    if(allData.length != 0) {
      var b = allData[0] as Map<String, dynamic>;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) =>
              homeScreen(allData: b,)), (Route<dynamic> route) => false);
    }
    else{
      navScreen(name(), context, true);
    }
  }

}

UpdateProfile(Map data,BuildContext context) async{
  User? user = await FirebaseAuth.instance.currentUser;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Map<String,dynamic> item = {
    "name":data['name'],
    "city":data['city'],
    "college":data['college'],
    "index":data['aindex'],
    "work":data['work'],
    "phone":user!.phoneNumber.toString(),
    "uid":user.uid.toString(),

  };



  await firestore.collection("user")
      .doc(user.uid)
      .set(item).then((value) => {
        toaster("Profile Updated Succesfully"),
    checker(context),
  });

}