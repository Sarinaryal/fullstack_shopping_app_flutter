import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/services/cloudinary_upload.dart';
import 'package:flutter_shopping_app/services/database.dart';
import 'package:flutter_shopping_app/widget/support_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  //final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  String? _uploadedImageUrl;
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController pricecontroller = new TextEditingController();
  TextEditingController detailcontroller = new TextEditingController();

  //list of dropdown icons
  final List<String> categoryitems = ['Watch', 'Laptop', 'TV', 'Headphones'];
  String? value;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });

      final url = await uploadImageToCloudinary(File(picked.path));

      setState(() {
        _uploadedImageUrl = url;
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_uploadedImageUrl != null && namecontroller.text != "") {
      String addId = randomAlphaNumeric(10);

      String firstletter = namecontroller.text.substring(0, 1).toUpperCase();

      Map<String, dynamic> addProduct = {
        "Name": namecontroller.text,
        "Image": _uploadedImageUrl,
        "SearchKey": firstletter,
        "UpdatedName": namecontroller.text.toUpperCase(),
        "Price": pricecontroller.text,
        "Detail": detailcontroller.text,
      };

      await DatabaseMethods().addProduct(addProduct, value!).then((
        value,
      ) async {
        await DatabaseMethods().addAllProducts(addProduct);
        _uploadedImageUrl = null;
        namecontroller.text = '';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              'Product uploaded successfully!',
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: Text('Add Product', style: AppWidget.mediumTextStyle()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Upload Image Section
              Text(
                'Upload the product image',
                style: AppWidget.lightTextFieldStyle(),
              ),
              SizedBox(height: 20),

              _uploadedImageUrl == null
                  ? GestureDetector(
                    onTap: _pickImage,
                    child: Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(Icons.camera_alt_outlined),
                      ),
                    ),
                  )
                  : Center(
                    child: Material(
                      elevation: 4.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            _uploadedImageUrl!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
              SizedBox(height: 20),

              //Product Name TextField
              Text('Product Name', style: AppWidget.lightTextFieldStyle()),
              SizedBox(height: 10),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(height: 20),

              //Product Price TextField
              Text('Product Price', style: AppWidget.lightTextFieldStyle()),
              SizedBox(height: 10),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: pricecontroller,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(height: 20),

              //Product Detail TextField
              Text('Product Detail', style: AppWidget.lightTextFieldStyle()),
              SizedBox(height: 10),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  maxLines: 6,
                  controller: detailcontroller,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(height: 20),

              //Product-category Dropdown
              Text('Product Category', style: AppWidget.lightTextFieldStyle()),
              SizedBox(height: 10),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    items:
                        categoryitems
                            .map(
                              (item) => DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  style: AppWidget.mediumTextStyle(),
                                ),
                              ),
                            )
                            .toList(),
                    onChanged:
                        (value) => setState(() {
                          this.value = value;
                        }),
                    dropdownColor: Colors.white,
                    hint: Text('Select Category'),
                    iconSize: 36,
                    icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                    value: value,
                  ),
                ),
              ),
              SizedBox(height: 30),

              //Add product btn
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _uploadImage();
                  },
                  child: Text('Add Product', style: TextStyle(fontSize: 22)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
