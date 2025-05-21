import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/pages/bottom_nav.dart';
import 'package:flutter_shopping_app/pages/login.dart';
import 'package:flutter_shopping_app/services/database.dart';
import 'package:flutter_shopping_app/services/shared_pref.dart';
import 'package:flutter_shopping_app/widget/support_widget.dart';
import 'package:random_string/random_string.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String? name, email, password;
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController mailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  //Global Key
  //checks if any field is empty -> shows the error
  final _formKey = GlobalKey<FormState>();

  registration() async {
    if (password != null && name != null && email != null) {
      try {
        //It creates new user account with provided email and password
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email!, password: password!);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              'Registered Successfully!!',
              style: TextStyle(fontSize: 20),
            ),
          ),
        );

        String Id = randomAlphaNumeric(10);

        //...
        int randomIndex = Random().nextInt(100);
        String imageUrl =
            'https://randomuser.me/api/portraits/men/$randomIndex.jpg';

        //saving user data on shared prefrences
        await SharedPreferenceHelper().saveUserEmail(mailcontroller.text);
        await SharedPreferenceHelper().saveUserId(Id);
        await SharedPreferenceHelper().saveUserName(namecontroller.text);
        await SharedPreferenceHelper().saveUserImage(imageUrl);

        //Storing the user details in database

        Map<String, dynamic> userInfoMap = {
          "Name": namecontroller.text,
          "Email": mailcontroller.text,
          "Id": Id,
          "Image": imageUrl,
        };

        //upload the data to database

        await DatabaseMethods().addUserDetails(userInfoMap, Id);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomNav()),
        );
      } on FirebaseException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                'Password Provided is too weak',
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                'Account already exists form this email',
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("images/login.png"),

                  Center(
                    child: Text('Sign Up', style: AppWidget.mediumTextStyle()),
                  ),
                  SizedBox(height: 20),

                  //Input User-Name field
                  Text('Name', style: AppWidget.mediumTextStyle()),
                  SizedBox(height: 10),

                  Container(
                    padding: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFF4F5F9),
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: TextFormField(
                      controller: namecontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter your Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name',
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  //Input Email field
                  Text('Email', style: AppWidget.mediumTextStyle()),
                  SizedBox(height: 10),

                  Container(
                    padding: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFF4F5F9),
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: TextFormField(
                      //TextFormField so that we can check the form state
                      controller: mailcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter your email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                      ),
                    ),
                  ),

                  //Input Password Field
                  SizedBox(height: 20),

                  Text('Password', style: AppWidget.mediumTextStyle()),
                  SizedBox(height: 10),

                  Container(
                    padding: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFF4F5F9),
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: TextFormField(
                      obscureText: true,
                      controller: passwordcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter your password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  //signup button
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          name = namecontroller.text;
                          email = mailcontroller.text;
                          password = passwordcontroller.text;
                        });
                      }
                      registration();
                    },
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: Center(
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  //Already have an account??
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: AppWidget.lightTextFieldStyle(),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
