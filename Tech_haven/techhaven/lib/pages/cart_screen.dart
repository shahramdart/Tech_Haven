// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:techhaven/Models/order_model.dart';
import 'package:techhaven/provider/app_state.dart';
import 'package:techhaven/widgets/my_textfield.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TextEditingController city = TextEditingController();
  TextEditingController town = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController comment = TextEditingController();

  Future<void> sendOrder(Order order) async {
    final url = Uri.parse('http://localhost:3000/api/orders');
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(order.toJson()),
      );
      if (response.statusCode == 200) {
        // ? agar response sarkawtw
        print('داواکاریەکەت سەرکەوتوبوو: ${response.body}');
      } else {
        // ? agar response sarkawtwnabu
        print(
            'ئۆردەرکردنەکە سەرکەوتوو نەبوو: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('هه‌ڵه‌یه‌ك ڕوویداوه‌: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontFamily: "English",
          ),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF193DB0),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          cartProvider.items.isEmpty
              ? Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      "!هیچ پڕۆداکتێک زیادنەکراوە بۆە سەبەتەکە",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "English",
                      ),
                    ),
                  ),
                )
              : Expanded(
                  flex: 3,
                  child: ListView.builder(
                    itemCount: cartProvider.items.length,
                    itemBuilder: (context, index) {
                      final item = cartProvider.items[index];
                      return Padding(
                        padding: EdgeInsets.all(8.0),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color:
                                            Color(0xFF193DB0).withOpacity(.1),
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
                                              item.productImage,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            width:
                                                200, // Example width constraint
                                            child: Text(
                                              "Product Name: ${item.productName}",
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
                                            "IQD ${item.productPrice}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            item.productSize,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  cartProvider
                                                      .decreaseQuantity(index);
                                                },
                                                child: Container(
                                                  height: 25,
                                                  width: 25,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    border: Border.all(
                                                      color: Colors.black,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.remove,
                                                      size: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text("${item.quantity}"),
                                              SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () {
                                                  cartProvider
                                                      .increaseQuantity(index);
                                                },
                                                child: Container(
                                                  height: 25,
                                                  width: 25,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    border: Border.all(
                                                      color: Colors.black,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.add,
                                                      size: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 20),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  cartProvider
                                                      .removeItem(index);
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          height: MediaQuery.of(context).size.height * 0.75,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Summary Order",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontFamily: "English",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Subtotal:",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            "IQD ${cartProvider.subtotal.toStringAsFixed(2)}",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE8EBF0),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Delivery Info",
                                              style: TextStyle(
                                                fontSize: 22,
                                                color: Color.fromARGB(
                                                    255, 48, 80, 184),
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "English",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                MyTextFields(
                                                  hintText: 'City',
                                                  controller: city,
                                                  width: 170,
                                                ),
                                                MyTextFields(
                                                  hintText: 'Town',
                                                  controller: town,
                                                  width: 160,
                                                ),
                                              ],
                                            ),
                                            MyTextFields(
                                              width: double.infinity,
                                              hintText: "Address",
                                              controller: address,
                                            ),
                                            MyTextFields(
                                              width: double.infinity,
                                              hintText: "Phone Number",
                                              controller: phoneNumber,
                                            ),
                                            MyTextFields(
                                              width: double.infinity,
                                              hintText: "Your Comment here",
                                              controller: comment,
                                              maxLines: 4,
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  onTap: () async {
                                                    Order order = Order(
                                                      city: city.text,
                                                      town: town.text,
                                                      address: address.text,
                                                      phoneNumber: phoneNumber
                                                              .text.isNotEmpty
                                                          ? phoneNumber.text
                                                          : 'N/A',
                                                      comment: comment.text,
                                                      total_price: 0,
                                                      items: cartProvider.items,
                                                    );

                                                    await sendOrder(order);
                                                    cartProvider.clearCart();
                                                    Navigator.pop(
                                                        context); // Close the modal sheet
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          '!داواکاریەکەت سەرکەوتوبوو',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'kurdish',
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 60,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .8,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF193DB0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Buy Now (${cartProvider.items.length})",
                                                        style: TextStyle(
                                                          fontSize: 22,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily: "English",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width * .8,
                    decoration: BoxDecoration(
                      color: Color(0xFF193DB0),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        "Buy Now (${cartProvider.items.length})",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: "English",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
