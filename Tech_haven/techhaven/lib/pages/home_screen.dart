// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:techhaven/pages/about_us.dart';
import 'package:techhaven/pages/cart_screen.dart';
import 'package:techhaven/pages/product_detail.dart';
import 'dart:convert';

class ProductByCategoryScreen extends StatefulWidget {
  const ProductByCategoryScreen({Key? key}) : super(key: key);

  @override
  _ProductByCategoryScreenState createState() =>
      _ProductByCategoryScreenState();
}

class _ProductByCategoryScreenState extends State<ProductByCategoryScreen> {
  List<String> myCategories = [];
  List<Map<String, dynamic>> products = [];
  List<Map<String, String>> images = [];

  bool isLoading = false;
  String selectedCategory = "All";

  // ? fetching categoryakan
  Future<void> fetchCategories() async {
    const String url = "http://localhost:3000/api/products/categories";
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)["data"];

        List<String> fetchedCategories = ["All"];
        fetchedCategories.addAll(data.cast<String>());

        setState(() {
          isLoading = false;
          myCategories = fetchedCategories;
        });

        // Fetch products when selected category
        if (myCategories.isNotEmpty) {
          fetchCategoriesProduct(selectedCategory);
        }
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print('Error fetching categories: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // ? calling products by category
  Future<void> fetchCategoriesProduct(String category) async {
    final String baseUrl = "http://localhost:3000/api/products";
    String url;

    if (category == "All") {
      url = baseUrl;
    } else {
      url = "$baseUrl/category/$category";
    }

    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)["data"];

        List<Map<String, dynamic>> fetchedProducts = [];
        data.forEach((product) {
          fetchedProducts.add(Map<String, dynamic>.from(product));
        });

        setState(() {
          products = fetchedProducts;
          selectedCategory = category;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching products: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tech Haven",
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontFamily: "English",
          ),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF193DB0),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    itemCount: myCategories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final category = myCategories[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            fetchCategoriesProduct(category);
                          },
                          child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                              color: category == selectedCategory
                                  ? Color(0xFF193DB0)
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                category,
                                style: TextStyle(
                                  fontSize: 17,
                                  color: category == selectedCategory
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: category == selectedCategory
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(
                                  product: product,
                                ),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width * .9,
                                  child: Row(
                                    children: [
                                      if (product["productImage"].isNotEmpty)
                                        Container(
                                          height: 200,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF193DB0)
                                                .withOpacity(.1),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              bottomLeft: Radius.circular(12),
                                            ),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                bottomLeft: Radius.circular(12),
                                              ),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  product["productImage"],
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        )
                                      else
                                        SizedBox(
                                          child: Text("No Image Found"),
                                        ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width:
                                                  200,
                                              child: Text(
                                                "Product Name: ${product["productName"] ?? ''}",
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "English",
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text(
                                              "IQD ${product['productPrice'] ?? ''}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              "${product['productSize'] ?? ''}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 100),
            Text(
              "TECH HAVEN",
              style: TextStyle(
                fontSize: 25,
                color: Color(0xFF193DB0),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.only(
                top: 70,
                left: 15,
              ),
              title: Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutUs(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.info,
                          size: 25,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "About us",
                          style: TextStyle(
                            fontFamily: "English",
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
