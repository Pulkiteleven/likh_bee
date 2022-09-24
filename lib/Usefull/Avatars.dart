import 'package:flutter/material.dart';
import 'package:likh_bee/Usefull/Colors.dart';

List<String> allAvatars = [
  'avatars/1.jpg',
  'avatars/2.jpg',
  'avatars/3.jpg',
  'avatars/4.jpg',
  'avatars/5.jpg',
  'avatars/6.jpg',
  'avatars/7.jpg',
  'avatars/8.jpg',
  'avatars/9.jpg',
  'avatars/10.jpg',
  'avatars/11.jpg',
  'avatars/12.jpg',
];



class circleAvatar extends StatelessWidget {
  int index;
  double radius;
  circleAvatar({Key? key,required this.index,required this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: bgColor,
      child: ClipOval(
        child: Image.asset(
          allAvatars[index],
          fit: BoxFit.cover,
        ),
      ),
    );

  }
}
