import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/widget/support_widget.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  Stream? orderStream;

  Widget allOrders() {
    return StreamBuilder(
      stream: orderStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];

                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10.0),
                      Image.network(
                        ds["Image"],
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10),
                      Text(ds["Name"], style: AppWidget.smallTextStyle()),
                      SizedBox(height: 10),

                      Spacer(),

                      Row(
                        children: [
                          Text(
                            '\$' + ds["Price"],
                            style: TextStyle(
                              color: Colors.deepOrangeAccent,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {},
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
                        ],
                      ),
                    ],
                  ),
                );
              },
            )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        backgroundColor: Color(0xfff2f2f2),
        title: Text('Current Orders', style: AppWidget.boldTextFieldStyle()),
        centerTitle: true,
      ),
      body: Container(child: Column(children: [

          ],
        )),
    );
  }
}
