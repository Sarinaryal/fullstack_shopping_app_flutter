import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/pages/bottom_nav.dart';
import 'package:flutter_shopping_app/pages/home.dart';
import 'package:flutter_shopping_app/pages/login.dart';
import 'package:flutter_shopping_app/services/database.dart';
import 'package:flutter_shopping_app/services/shared_pref.dart';
import 'package:flutter_shopping_app/widget/support_widget.dart';

class ProductDetail extends StatefulWidget {
  final String image, name, detail, price;
  const ProductDetail({
    super.key,
    required this.image,
    required this.name,
    required this.detail,
    required this.price,
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  //get username from shared prefrences
  String? name, mail, image;

  getthesharedpref() async {
    name = await SharedPreferenceHelper().getUserName();
    mail = await SharedPreferenceHelper().getUserEmail();
    image = await SharedPreferenceHelper().getUserImage();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    ontheload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 218, 212, 221),
      body: Container(
        padding: EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                //product-detail image container
                Center(child: Image.network(widget.image, height: 400)),

                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20),

                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(Icons.arrow_back_ios_new_outlined),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            //Container for product-description
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                width: MediaQuery.of(context).size.width,

                //Product_description Column
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Product-name and price row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.name,
                          style: AppWidget.boldTextFieldStyle(),
                        ),

                        Text(
                          "Rs" + widget.price,
                          style: TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text('Details', style: AppWidget.mediumTextStyle()),
                    SizedBox(height: 20),

                    Text(
                      widget.detail,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 70),

                    GestureDetector(
                      onTap: () {
                        placeOrder();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BottomNav()),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Color(0xFFfd6f3e),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: MediaQuery.of(context).size.width,

                        child: Center(
                          child: Text(
                            "Buy Now",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  placeOrder() async {
    Map<String, dynamic> orderInfoMap = {
      "Product": widget.name,
      "Price": widget.price,
      "Name": name,
      "Email": mail,
      "Image": image,
      "ProductImage": widget.image,
      "Status": "On the way",
    };
    await DatabaseMethods().orderDetails(orderInfoMap);
  }

  //showDialog()
  // calculateAmount(String amount) {
  //   final calculatedAmount = (int.parse(amount) * 100);
  //   return calculatedAmount.toString();
  // }
}
