import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_shopping_app/pages/login.dart';

//import 'package:flutter_shopping_app/pages/product_detail.dart';

import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:cloudinary_flutter/image/cld_image.dart';
import 'package:flutter_shopping_app/pages/onboarding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //Cloudinary Setup here
  CloudinaryContext.cloudinary = Cloudinary.fromCloudName(
    cloudName: 'dgipszkn7',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of application.
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
      //home: Signup(),
      //home: AdminLogin(),
      //home: AddProduct(),
      //home: UploadPage(),
      //home: AllOrders(),
      //home : Profile(),
      //home: HomeAdmin(),
      home: Onboarding(),
    );
  }
}
