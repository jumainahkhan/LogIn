import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:login/Screens/signup/sign_up_one.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: HexColor("#8d8d8d"),
            ),
      ),
      home: const SignUpOne(),
    );
  }
}
