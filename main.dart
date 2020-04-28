import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: Scaffold(
        body: Center(child: LoadingButton()),
      ),
    );
  }
}

class LoadingButton extends StatefulWidget {
  @override
  LoadingButtonState createState() => LoadingButtonState();
}

class LoadingButtonState extends State<LoadingButton>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => controller.forward(),
      onTapUp: (_) {
        controller.value = min(controller.value,0.99);
        if (controller.status == AnimationStatus.forward) {
          controller.value = min(controller.value,0.99);
          controller.reverse();
          print(controller.value);
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SizedBox(
            height: 200,
            width: 200,
            child: CircularProgressIndicator(
              strokeWidth: 10,
              value: 1.0,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
            ),
          ),
          SizedBox(
            height: 200,
            width: 200,
            child: CircularProgressIndicator(
              strokeWidth: 10,
              value: controller.value,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
          Icon(controller.value > 0.99?Icons.verified_user:Icons.fingerprint,size: 200.0,)
        ],
      ),
    );
  }
}