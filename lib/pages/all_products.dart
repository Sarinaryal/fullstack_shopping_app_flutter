import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/pages/product_detail.dart';
import 'package:flutter_shopping_app/services/database.dart';
import 'package:flutter_shopping_app/widget/support_widget.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  Stream<QuerySnapshot>? productStream;

  ontheload() async {
    productStream = DatabaseMethods().allProducts();
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  Widget allProducts() {
    return StreamBuilder(
      stream: productStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
          return Center(child: Text("No products found."));
        }

        return GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          //scrollDirection: Axis.horizontal,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];
            return Container(
              //margin: EdgeInsets.only(right: 20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Image.network(
                    ds["Image"],
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10),
                  Text(ds["Name"], style: AppWidget.mediumTextStyle()),
                  SizedBox(height: 10),
                  Spacer(),

                  Row(
                    children: [
                      Expanded(
                        flex: 20,
                        child: Text(
                          'Rs' + ds["Price"],
                          style: TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => ProductDetail(
                                    image: ds["Image"],
                                    name: ds["Name"],
                                    detail: ds["Detail"],
                                    price: ds["Price"],
                                  ),
                            ),
                          );
                        },
                        child: Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.deepOrangeAccent,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 218, 212, 221),
      appBar: AppBar(
        title: Text('All Products'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 218, 212, 221),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Column(children: [Expanded(child: allProducts())]),
      ),
    );
  }
}
