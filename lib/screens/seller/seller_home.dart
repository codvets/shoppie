import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/change_notifiers/auth_notifier.dart';
import 'package:shop_app/providers/change_notifiers/home_notifier.dart';
import 'package:shop_app/utils/screen_utils.dart';

class SellerHome extends StatefulWidget {
  SellerHome({Key? key}) : super(key: key);

  @override
  State<SellerHome> createState() => _SellerHomeState();
}

class _SellerHomeState extends State<SellerHome> {
  final _formKey = GlobalKey<FormState>();

  File? file;

  TextEditingController _productController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  String? _category;
  int? _discount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  final ImageSource? source =
                      await ScreenUtils.imagePickOptions(context);
                  if (source != null) {
                    final rawFile =
                        await ImagePicker().pickImage(source: source);
                    if (rawFile != null) {
                      setState(() {
                        file = File(rawFile.path);
                      });
                    }
                    // final file = File();
                  }
                },
                child: CircleAvatar(
                  backgroundImage: file != null ? FileImage(file!) : null,
                  radius: 100,
                  child: file != null
                      ? SizedBox()
                      : Center(
                          child: Icon(
                            Icons.camera_alt,
                            size: 35,
                          ),
                        ),
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12),
                  child: Theme(
                    data: ThemeData(
                      inputDecorationTheme: InputDecorationTheme(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _productController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Empty field";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              label: Text(
                                'Product Title',
                              ),
                              hintText: "Nike Air",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _descriptionController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Empty field";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              label: Text(
                                'Description',
                              ),
                              hintText: "Nike Air is good",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _priceController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Empty field";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              label: Text(
                                'Price',
                              ),
                              hintText: "25.00",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField<String>(
                            validator: (val) {
                              if (val == null) {
                                return "Select a category";
                              }

                              return null;
                            },
                            hint: Text("Select category"),
                            onChanged: (val) {
                              _category = val!;
                            },
                            items: categories.map((cat) {
                              return DropdownMenuItem<String>(
                                value: cat,
                                child: Text(cat),
                              );
                            }).toList(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField<int>(
                            hint: Text("Select discount"),
                            onChanged: (val) {
                              _discount = val;
                            },
                            items: discountOptions.map((discount) {
                              return DropdownMenuItem<int>(
                                value: discount,
                                child: Text("${discount.toString()}%"),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (file == null || _category == null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("File or Category is empty"),
                      ));
                      return;
                    }
                    Provider.of<HomeNotifier>(context, listen: false)
                        .uploadProduct(
                      context,
                      category: _category!,
                      description: _descriptionController.text,
                      title: _productController.text,
                      price: double.parse(_priceController.text),
                      discount: _discount,
                      image: file!,
                      sellerId:
                          Provider.of<AuthNotifier>(context, listen: false)
                              .currentUser
                              .uid,
                    );
                  }
                },
                child: Text('Upload Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> categories = ["Shoes", "Clothes", "Pants", "Shirts"];
  List<int> discountOptions = [5, 10, 15, 30];
}
