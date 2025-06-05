import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/pages/login.dart';
import 'package:flutter_shopping_app/pages/signup.dart';
import 'package:flutter_shopping_app/services/auth.dart';
import 'package:flutter_shopping_app/services/cloudinary_upload.dart';
import 'package:flutter_shopping_app/services/database.dart';
import 'package:flutter_shopping_app/services/shared_pref.dart';
import 'package:flutter_shopping_app/widget/support_widget.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? image, name, email;
  String? imageUrl;
  File? _selectedImage;

  getthesharedpref() async {
    image = await SharedPreferenceHelper().getUserImage();
    name = await SharedPreferenceHelper().getUserName();
    email = await SharedPreferenceHelper().getUserEmail();

    setState(() {});
  }

  //to get all the data as soon as the profile page loads
  @override
  void initState() {
    getthesharedpref();
    super.initState();
  }

  Future<void> _pickAndUplaodImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });

      final url = await uploadImageToCloudinary(File(picked.path));

      setState(() {
        imageUrl = url;
      });

      //get the current users id
      final id = FirebaseAuth.instance.currentUser?.uid;

      if (id != null) {
        await DatabaseMethods().updateUserImageByUid(id, imageUrl!);

        //update shared prefrences
        await SharedPreferenceHelper().saveUserImage(imageUrl!);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile picture updated successfully!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        backgroundColor: Color(0xfff2f2f2),
        title: Text('Profile', style: AppWidget.boldTextFieldStyle()),
        centerTitle: true,
        automaticallyImplyLeading: false, //hides the back arrow
      ),
      body:
          name == null
              ? Center(child: CircularProgressIndicator())
              : Container(
                child: Column(
                  children: [
                    imageUrl != null
                        ? Center(
                          child: GestureDetector(
                            onTap: _pickAndUplaodImage,

                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.brown,
                                  width: 2,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(70),

                                child: Image.network(
                                  imageUrl!,
                                  height: 140,
                                  width: 140,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        )
                        : Center(
                          child: GestureDetector(
                            onTap: () {
                              _pickAndUplaodImage();
                            },

                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(70),
                              child: Image.network(
                                image!,
                                height: 140,
                                width: 140,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: 3,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Icon(Icons.person_outline, size: 35),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                flex: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name",
                                      style: AppWidget.lightTextFieldStyle(),
                                    ),
                                    Text(
                                      name!,
                                      style: AppWidget.mediumTextStyle(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //user_email
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: 3,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Icon(Icons.mail_outline, size: 33),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                flex: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Email",
                                      style: AppWidget.lightTextFieldStyle(),
                                    ),
                                    Container(
                                      child: Text(
                                        email!,
                                        style: AppWidget.mediumTextStyle(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //Sign_out btn
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        await AuthMethods().signOut().then((value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          elevation: 3,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.logout, size: 35),
                                SizedBox(width: 10),

                                Text(
                                  "Log Out",
                                  style: AppWidget.mediumTextStyle(),
                                ),

                                Spacer(),

                                Icon(Icons.arrow_forward_ios_outlined),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    //Delete account btn
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        await AuthMethods().deleteUser().then((value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Signup()),
                          );
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          elevation: 3,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.delete_outline, size: 35),
                                SizedBox(width: 10),

                                Text(
                                  "Delete Account",
                                  style: AppWidget.mediumTextStyle(),
                                ),

                                Spacer(),

                                Icon(Icons.arrow_forward_ios_outlined),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
