import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:likh_bee/Usefull/Colors.dart';
import 'package:likh_bee/Backend/backend.dart';
import 'package:likh_bee/Usefull/Buttons.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';
import 'dart:async';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';



final _messangerKey = GlobalKey<ScaffoldMessengerState>();


class enterOtp extends StatefulWidget {
  String number;
  String vId;
  enterOtp({Key? key,required this.number,required this.vId}) : super(key: key);
  

  @override
  State<enterOtp> createState() => _enterOtpState();
}

class _enterOtpState extends State<enterOtp> {
  final formKey = GlobalKey<FormState>();
  int _otpCodeLength = 6;
  bool _isLoadingButton = false;
  bool _enableButton = false;
  String _otpCode = "";
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final intRegex = RegExp(r'\d+', multiLine: true);
  TextEditingController textEditingController = new TextEditingController(text: "");

  FirebaseAuth _auth = FirebaseAuth.instance;

  bool isHide = false;

  late BuildContext mCtx;




  _getSignatureCode() async {
    String? signature = await SmsVerification.getAppSignature();
    print("signature $signature");
  }

  _startListeningSms()  {
    SmsVerification.startListeningSms().then((message) {
      setState(() {
        _otpCode = SmsVerification.getCode(message, intRegex);
        textEditingController.text = _otpCode;
        _onOtpCallBack(_otpCode, true);
      });
    });
  }

  _onSubmitOtp() {
    setState(() {
      _isLoadingButton = !_isLoadingButton;
      _verifyOtpCode();
    });
  }

  _onClickRetry() {
    _startListeningSms();
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      this._otpCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill) {
        _enableButton = false;
        _isLoadingButton = true;
        _verifyOtpCode();
      } else if (otpCode.length == _otpCodeLength && !isAutofill) {
        _enableButton = true;
        _isLoadingButton = false;
      } else {
        _enableButton = false;
      }
    });
  }

  _verifyOtpCode() {
    FocusScope.of(context).requestFocus(new FocusNode());
    Timer(Duration(milliseconds: 4000), () {
      setState(() {
        _isLoadingButton = false;
        _enableButton = false;
      });

      _scaffoldKey.currentState?.showSnackBar(
          SnackBar(content: Text("Verification OTP Code $_otpCode Success")));
    });
  }


  @override
  void initState() {
    _getSignatureCode();
    _startListeningSms();
  }


  @override
  void dispose() {
    SmsVerification.stopListening();
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  @override
  Widget build(BuildContext context) {

    mCtx = context;

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
                    padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
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
                                    mainText("OTP", darktext, 25.0, FontWeight.bold, 1),
                                    SizedBox(height: 15.0,),
                                    mainText("Enter Your OTP", darktext, 15.0, FontWeight.normal, 1),
                                    SizedBox(height: 15.0,),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 0.0),
                                      child: OtpTextField(
                                        numberOfFields: 6,
                                        borderColor: mainColor,
                                        disabledBorderColor: darkblue,
                                        borderRadius: BorderRadius.circular(5.0),
                                        showFieldAsBox: false,
                                        textStyle: TextStyle(
                                            color: darkblue
                                        ),
                                        onSubmit: (String value){
                                          _otpCode = value;
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
                  btnsss("LOGIN NOW", () { LoginwithOTP();}, mainColor, yellowColor),
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

  Future LoginwithOTP() async{
    setState((){
      isHide = true;
    });
    var _cred = PhoneAuthProvider.credential(
    verificationId: widget.vId,
    smsCode: _otpCode);
    _auth.signInWithCredential(_cred).then((value) => {
      setState((){
        isHide = false;
      }),
      checker(context),
      print("ho gya")
    }).catchError((e){
      snacker("Something Went Wrong", mCtx);
      setState((){
        isHide = false;
      });
    });
    // if(formKey.currentState!.validate()){
    //   setState((){
    //     isHide = true;
    //   });
    //   await _auth.verifyPhoneNumber(
    //       phoneNumber: widget.number,
    //       verificationCompleted: _onVerificationCompleted,
    //       verificationFailed: _onVerificationFailed,
    //       codeSent: _onCodeSent,
    //       codeAutoRetrievalTimeout: _onCodeTimeout);
    // }
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
    if (exception.code == 'invalid-phone-number') {
      setState((){
        isHide = false;
      });
      Snacker("Please Enter an Valid Phone Number", _messangerKey);
    }
  }

  _onCodeSent(String verificationId, int? forceResendingToken) {
    verificationId = verificationId;
    print(forceResendingToken);
    Snacker("OTP send Successfully", _messangerKey);
  }

  _onCodeTimeout(String timeout) {
    return null;
  }
}

