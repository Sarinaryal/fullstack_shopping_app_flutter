import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/pages/onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        textTheme: TextTheme(
          titleLarge: TextStyle(
            color: Colors.black,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
          ),
        ),
      ),
      

      home: Onboarding(),
      //home: Home(),
    );
  }
}
