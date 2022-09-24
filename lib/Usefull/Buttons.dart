import 'package:flutter/material.dart';

import 'Colors.dart';


class btnsss extends StatelessWidget {
  VoidCallback callback;
  String title;
  Color main;
  Color text;

  btnsss(this.title,this.callback,this.main,this.text);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
        child: mainText(
            title, text, 13.0, FontWeight.normal,1),
      ),
      style: ButtonStyle(
          foregroundColor:
          MaterialStateProperty.all<Color>(
              main),
          backgroundColor:
          MaterialStateProperty.all<Color>(main),
          shape: MaterialStateProperty.all<
              RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(15.0),
                  side: BorderSide(color: main)))),
      onPressed: callback,
    );
  }
}



class fullbtnsss extends StatelessWidget {
  VoidCallback callback;
  String title;
  Color main;
  Color text;

  fullbtnsss(this.title,this.callback,this.main,this.text);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
        child: Row(
          children: [
            Spacer(),
            mainText(
                title, text, 13.0, FontWeight.normal,1),
            Spacer()
          ],
        ),
      ),
      style: ButtonStyle(
          foregroundColor:
          MaterialStateProperty.all<Color>(
              main),
          backgroundColor:
          MaterialStateProperty.all<Color>(main),
          shape: MaterialStateProperty.all<
              RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(15.0),
                  side: BorderSide(color: main)))),
      onPressed: callback,
    );
  }
}


class btnshome extends StatelessWidget {
  VoidCallback callback;
  String title;
  Color main;
  Color text;

  btnshome(this.title,this.callback,this.main,this.text);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: mainText(
            title, text, 13.0, FontWeight.normal,1),
      ),
      style: ButtonStyle(
          foregroundColor:
          MaterialStateProperty.all<Color>(
              main),
          backgroundColor:
          MaterialStateProperty.all<Color>(main),
          shape: MaterialStateProperty.all<
              RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(10.0),
                  side: BorderSide(color: main)))),
      onPressed: callback,
    );
  }
}


