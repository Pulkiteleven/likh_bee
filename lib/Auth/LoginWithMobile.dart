import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:likh_bee/Auth/OtpLogin.dart';
import 'package:likh_bee/Usefull/Buttons.dart';
import 'package:likh_bee/Usefull/Colors.dart';
import 'package:likh_bee/Usefull/Functions.dart';


final _messangerKey = GlobalKey<ScaffoldMessengerState>();


class otpLogin extends StatefulWidget {
  const otpLogin({Key? key}) : super(key: key);


  @override
  State<otpLogin> createState() => _otpLoginState();
}

class _otpLoginState extends State<otpLogin> {
  final formKey = GlobalKey<FormState>();
  String phone = "";
  bool isHide = false;
  FirebaseAuth _auth = FirebaseAuth.instance;



  @override
  void initState() {
    print("hello");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: _messangerKey,
      home: Scaffold(
        backgroundColor: bgColor,
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.35,
              color: mainColor,
              child: Image.asset(
                'Assets/nnlb.png',
                width: 40.0,
                scale: 5,
              ),
            ),

            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width:MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.28),
                    padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                    child: Card(
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                        child: Form(
                          key: formKey,
                          child: (
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              mainText("Login", darktext, 25.0, FontWeight.bold, 1),
                              SizedBox(height: 15.0,),
                              mainText("Enter Your Mobile Number", darktext, 15.0, FontWeight.normal, 1),
                              SizedBox(height: 15.0,),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 0.0),
                                child: TextFormField(
                                  maxLength: 10,
                                  keyboardType:TextInputType.number,
                                  cursorColor: Colors.white,
                                  style: TextStyle(
                                    fontFamily: 'pop',
                                    fontSize: 15.0,
                                    color: darkblue,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Mobile Number",
                                      labelStyle: TextStyle(
                                        fontFamily: 'pop',
                                        color:lightColor,
                                      ),
                                      errorStyle: TextStyle(
                                          fontFamily: 'pop',
                                          color: errorColor
                                      ),
                                      errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: errorColor
                                          )
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white
                                          )
                                      )
                                  ),

                                  onChanged: (text){
                                    phone = text;
                                  },
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return("Please Enter a Number");
                                    }
                                    else if(value.length < 10){
                                      return("Number should be 10 digits long");
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          )
                          ),
                        ),
                      )
                    ),

                  ),


                  SizedBox(height: 20.0,),
                  btnsss("GET OTP", () { LoginwithMobile();}, mainColor, yellowColor),
                  SizedBox(height: 15.0,),
                  Row(
                    children: [
                      Spacer(),
                      mainText("Pay Write ", darkblue, 13.0, FontWeight.normal, 1,),
                      mainText("and Hire", yellowColor, 13.0, FontWeight.normal, 1,),

                      Spacer(),
                    ],
                  )

                ],
              ),
            ),
            loaderss(isHide, context)
          ],
        ),
      ),
    );
  }
  Future LoginwithMobile() async{
    if(formKey.currentState!.validate()){
      setState((){
        isHide = true;
      });
      await _auth.verifyPhoneNumber(
          phoneNumber: "+91" + phone,
          verificationCompleted: _onVerificationCompleted,
          verificationFailed: _onVerificationFailed,
          codeSent: _onCodeSent,
          codeAutoRetrievalTimeout: _onCodeTimeout);
    }
  }


  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    print("verification completed ${authCredential.smsCode}");
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      // this.otpCode.text = authCredential.smsCode!;
    });
    if (authCredential.smsCode != null) {
      try{
        UserCredential credential =
        await user!.linkWithCredential(authCredential);
      }on FirebaseAuthException catch(e){
        if(e.code == 'provider-already-linked'){
          await _auth.signInWithCredential(authCredential);
        }
      }
      setState(() {
        isHide = false;
      });
    }
  }

  _onVerificationFailed(FirebaseAuthException exception) {
    print(exception.code);
    if (exception.code == 'invalid-phone-number') {
      setState((){
        isHide = false;
      });
      Snacker("Please Enter an Valid Phone Number", _messangerKey);
    }
  }

  _onCodeSent(String verificationId, int? forceResendingToken) {
    print("Bhij Gaya");
    verificationId = verificationId;
    print(forceResendingToken);
    Snacker("OTP send Successfully", _messangerKey);
    navScreen(enterOtp(number: phone,vId: verificationId,), context, false);
  }

  _onCodeTimeout(String timeout) {
    return null;
  }
}


