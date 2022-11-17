import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fluttertoast/fluttertoast.dart';

Color bgColor = Color(0xFFEFEFEF);
Color darkColor = Color(0XFF011F44);

Color darkblue = Color(0xFF011F44);
Color shimmerColor = Color(0xFFE0E0E0);
Color mainColor = Color(0xFF0059BF);
Color lightColor = Color(0xFF58B1F9);

Color yellowColor = Color(0xFFFFB800);
Color lightyellowColor = Color(0xFFFFBC42);


Color? textColor = Colors.cyan[900];
Color darktext = Color(0xFF263238);
Color lightText = Color(0xFFA8A8A8);
Color textlight = Color(0xFF727272);
Color errorColor = Color(0xFFFF2E2E);

Color acceptedColor = Color(0xFF6BBAFF);

Color transparent_overlay = Color(0xFFFFFF);


Color item_one = const Color(0xFFE0E0FF);
Color item_two = const Color(0xFFFFE0E0);
Color item_three = const Color(0xFFD4FFEB);
Color item_four = const Color(0xFFFFF5D4);

Color item_one_light = const Color(0xFFC2C2FF);
Color item_two_light = const Color(0xFFFFA4A4);
Color item_three_light = const Color(0xFF98FFE8);
Color item_four_light = const Color(0xFFFFEA91);


Color item_one_top = const Color(0xFF5050FF);
Color item_two_top = const Color(0xFFFF5D5D);
Color item_three_top = const Color(0xFF5BFFAE);
Color item_four_top = const Color(0xFFFFDA2A);

Color bottom_one = Color(0xFF4B4BFF);
Color bottom_two = Color(0xFFC6B41B);
Color bottom_three = Color(0xFFC42283);

Color iconColor = Color(0xFFDADADA);

Color ligth_item_one = const Color(0x80E0E0FF);
Color light_item_two = const Color(0x80FFE0E0);
Color light_item_three = const Color(0x80D4FFEB);
Color light_item_four = const Color(0x80FFF5D4);

String mainFont = 'pop';
String mainFontLight = 'pop';

String popfont = 'round';

AutoSizeText mainText(String text, Color c, double size, FontWeight w,int lines) {
  return AutoSizeText(
    text,
    textAlign: TextAlign.center,
    maxLines: lines,
    style: TextStyle(
      color: c,
      letterSpacing: 0.5,
      fontSize: size,
      fontFamily: mainFont,
      fontWeight: w,

    ),
  );
}


Text mainTextPop(String text, Color c, double size, FontWeight w,int lines) {
  return Text(
    text,
    textAlign: TextAlign.center,
    maxLines: lines,
    style: TextStyle(
      color: c,
      letterSpacing: 0.5,
      fontSize: size,
      fontFamily: popfont,
      fontWeight: w,

    ),
  );
}

AutoSizeText mainTextFAQS(String text, Color c, double size, FontWeight w,int lines) {
  return AutoSizeText(
    text,
    textAlign: TextAlign.start,
    maxLines: lines,
    style: TextStyle(
      color: c,
      letterSpacing: 0.5,
      fontSize: size,
      fontFamily: mainFont,
      fontWeight: w,

    ),
  );
}


Text mainTextLeft(String text, Color c, double size, FontWeight w,int lines) {
  return Text(

    text,
    textAlign: TextAlign.start,
    maxLines: lines,
    softWrap: false,
    overflow: TextOverflow.fade,
    style: TextStyle(
      color: c,
      letterSpacing: 0.5,
      fontSize: size,
      fontFamily: mainFontLight,
      fontWeight: w,
    ),
  );
}

Text mainTextLight(String text, Color c, double size, FontWeight w,int lines) {
  return Text(

    text,
    textAlign: TextAlign.center,
    maxLines: lines,

    style: TextStyle(
        color: c,
        letterSpacing: 0.5,
        fontSize: size,
        fontFamily: mainFontLight,
        fontWeight: w,
        overflow: TextOverflow.ellipsis
    ),
  );
}


class loader extends StatelessWidget {
  const loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      child: new Container(
        height: 90.0,
        width: 90.0,
        child: new Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.white,
          elevation: 7.0,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey,
              color: mainColor,
              strokeWidth: 5,
            ),
          ),
        ),
      ),
    );
  }
}


Widget loaderss(bool a,BuildContext context){
  return Visibility(
      visible: a,
      child: Stack(
        children: [
          Visibility(
            visible: a,
            child: new Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: new Card(
                color: transparent_overlay,
                elevation: 4.0,
              ),
            ),
          ),
          Visibility(visible: a, child: loader())
        ],
      ));
}
void Snacker(String title,GlobalKey<ScaffoldMessengerState> aa){
  final snackBar = SnackBar(
      elevation: 0,
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      backgroundColor: lightColor,
      content:Text(title) );

  aa.currentState?.showSnackBar(snackBar);
  // messangerKey.currentState?.showSnackBar(snackBar);

}

void snacker(String s, BuildContext c){
  ScaffoldMessenger.of(c).showSnackBar(SnackBar(
      elevation: 0,
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      backgroundColor: lightColor,
      content:
  Text(s)));
}

toaster(String msg){
  Fluttertoast.showToast(msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      backgroundColor: mainColor);

}






