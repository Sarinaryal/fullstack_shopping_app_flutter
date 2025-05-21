import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/pages/bottom_nav.dart';
import 'package:flutter_shopping_app/pages/category_products.dart';
import 'package:flutter_shopping_app/pages/product_detail.dart';
import 'package:flutter_shopping_app/services/shared_pref.dart';
import 'package:flutter_shopping_app/widget/support_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List categories = [
    "images/headphone_icon.png",
    "images/laptop.png",
    "images/watch.png",
    "images/TV.png",
  ];

  List Categoryname = ['Headphones', 'Laptop', 'Watch', 'TV'];

  String? name, image;
  getthesharedpref() async {
    name = await SharedPreferenceHelper().getUserName();
    image = await SharedPreferenceHelper().getUserImage();

    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),

      body:
          name == null
              ? Center(child: CircularProgressIndicator())
              : Container(
                margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Hey, $name!',
                              style: AppWidget.boldTextFieldStyle(),
                            ),

                            Text(
                              'Good Morning!!',
                              style: AppWidget.lightTextFieldStyle(),
                            ),
                          ],
                        ),

                        ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image.network(
                            image!,
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 30),

                    //Search Product Text Field
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width:
                          MediaQuery.of(
                            context,
                          ).size.width, //uses complete width pf the screen
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search Products',
                          hintStyle: AppWidget.lightTextFieldStyle(),
                          prefixIcon: Icon(Icons.search, color: Colors.black),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    //categories and filters row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Categories', style: AppWidget.mediumTextStyle()),
                        Text(
                          'see all',
                          style: TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    Row(
                      children: [
                        Container(
                          height: 130,
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            color: Colors.deepOrangeAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: Center(
                            child: Text(
                              'All',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 130,
                            child: ListView.builder(
                              itemCount: categories.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return CategoryTile(
                                  image: categories[index],
                                  name: Categoryname[index],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 30),

                    // Display all products
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'All Products',
                          style: AppWidget.mediumTextStyle(),
                        ),
                        Text(
                          'see all',
                          style: TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    Container(
                      height: 250,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: GestureDetector(
                              // onTap: () {
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => ProductDetail(),
                              //     ),
                              //   );
                              // },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "images/headphone2.png",
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  Text(
                                    'Headphone',
                                    style: AppWidget.mediumTextStyle(),
                                  ),
                                  SizedBox(height: 10),

                                  Row(
                                    children: [
                                      Text(
                                        '\$100',
                                        style: TextStyle(
                                          color: Colors.deepOrangeAccent,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      SizedBox(width: 50),
                                      Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.deepOrangeAccent,
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //second Product list
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  "images/watch2.png",
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  'Apple Watch',
                                  style: AppWidget.mediumTextStyle(),
                                ),
                                SizedBox(height: 10),

                                Row(
                                  children: [
                                    Text(
                                      '\$300',
                                      style: TextStyle(
                                        color: Colors.deepOrangeAccent,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    SizedBox(width: 50),
                                    Container(
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
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // second Products ends
                        ],
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String image, name;
  const CategoryTile({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryProduct(category: name),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(image, height: 50, width: 50, fit: BoxFit.cover),

            Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}
