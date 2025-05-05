import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/widget/support_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 40, left: 20),
        child: Column(
          children: [
            Text('hey, Sarina', style: AppWidget.boldTextFieldStyle()),
            Text(
              'Good Morning!!',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
