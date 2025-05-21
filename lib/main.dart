import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/Admin/add_product.dart';
import 'package:flutter_shopping_app/Admin/admin_login.dart';
import 'package:flutter_shopping_app/pages/home.dart';
import 'package:flutter_shopping_app/pages/bottom_nav.dart';
import 'package:flutter_shopping_app/pages/login.dart';
import 'package:flutter_shopping_app/pages/onboarding.dart';
import 'package:flutter_shopping_app/pages/product_detail.dart';
import 'package:flutter_shopping_app/pages/signup.dart';
//import 'package:flutter_shopping_app/pages/product_detail.dart';

import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:cloudinary_flutter/image/cld_image.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //Cloudinary Setup here
  CloudinaryContext.cloudinary = Cloudinary.fromCloudName(
    cloudName: 'your_cloud_name', // Replace with your actual cloud name
  );

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


      //home: Onboarding(),
      //home: Home(),
      //home: BottomNav(),
      //home: ProductDetail(),
      //home: Login(),
      home: Signup(),
      //home: AdminLogin(),
      //home: AddProduct(),
      //home: UploadPage(),
    );
  }
}
