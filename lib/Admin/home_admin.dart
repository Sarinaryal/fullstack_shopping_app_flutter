import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/Admin/add_product.dart';
import 'package:flutter_shopping_app/Admin/all_orders.dart';
import 'package:flutter_shopping_app/widget/support_widget.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        backgroundColor: Color(0xfff2f2f2),
        title: Text('Home Admin', style: AppWidget.boldTextFieldStyle()),
        centerTitle: true,
      ),

      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProduct()),
                );
              },
              child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  width: MediaQuery.of(context).size.width / 2.2,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 177, 172, 172),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, size: 30),
                      SizedBox(width: 5),
                      Text(
                        'Add Product',
                        style: AppWidget.lightTextFieldStyle(),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(width: 10),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllOrders()),
                );
              },
              child: Material(
                borderRadius: BorderRadius.circular(5),
                elevation: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  width: MediaQuery.of(context).size.width / 2.2,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 177, 172, 172),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_bag_outlined, size: 30),
                      SizedBox(width: 5),
                      Text(
                        'All Orders',
                        style: AppWidget.lightTextFieldStyle(),
                      ),
                    ],
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
