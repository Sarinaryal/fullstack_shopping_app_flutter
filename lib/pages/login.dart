import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/widget/support_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("images/login.png"),

              Center(
                child: Text('Sign In', style: AppWidget.mediumTextStyle()),
              ),
              SizedBox(height: 20),

              Text(
                'Please enter the details below to \n                    continue',
                style: AppWidget.lightTextFieldStyle(),
              ),
              SizedBox(height: 40),

              Text('Email', style: AppWidget.mediumTextStyle()),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF4F5F9),
                  borderRadius: BorderRadius.circular(10),
                ),

                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
