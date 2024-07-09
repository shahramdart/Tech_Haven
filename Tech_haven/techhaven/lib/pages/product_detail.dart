// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techhaven/Models/cart_model.dart';
import 'package:techhaven/provider/app_state.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? selectedColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product['productName'] ?? 'Product Detail',
          style: TextStyle(
            fontFamily: "English",
            fontWeight: FontWeight.w600,
          ),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF193DB0),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.product["productImage"].isNotEmpty)
            Container(
              height: 450,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    widget.product["productImage"],
                  ),
                  fit: BoxFit.scaleDown,
                ),
              ),
            )
          else
            Container(
              height: 200,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text("هیچ وێنەیەک بوونی نیە"),
            ),
          SizedBox(height: 13),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 400,
                      child: Text(
                        "Product Name: ${widget.product["productName"] ?? ''}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "English",
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        "Description: ${widget.product['productDescription'] ?? 'No description available'}",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "English",
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      "Color: ",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "English",
                      ),
                    ),
                    Row(
                      children: _buildColorCircles(
                        widget.product['productColor'],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      "Size: ",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "English",
                      ),
                    ),
                    Text(
                      widget.product['productSize'] ??
                          'No description available',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "English",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Divider(),
                SizedBox(height: 15),
                Row(
                  children: [
                    Text(
                      "Price: ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                        fontFamily: "English",
                      ),
                    ),
                    Text(
                      "IQD ${widget.product['productPrice'] ?? ''}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                        fontFamily: "English",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  if (selectedColor == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "!تکایە ڕەنگێک هەڵبژێرە",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: "kurdish",
                          ),
                        ),
                      ),
                    );
                    return;
                  } else {
                    _addToCart(widget.product);
                  }
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
                      "Add To Cart",
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
        ],
      ),
    );
  }

  void _addToCart(Map<String, dynamic> product) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    CartItem cartItem = CartItem(
      productName: product['productName'],
      productPrice: double.parse(product['productPrice']),
      productSize: product['productSize'] ?? 'No Size',
      productImage: product['productImage'],
    );
    cartProvider.addItem(cartItem);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "زیادکراوە بۆ سەبەتە",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: "kurdish",
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // ? ddruskrdny circleky rangakan la jyaty text
  List<Widget> _buildColorCircles(String? productColors) {
    if (productColors == null || productColors.isEmpty) {
      return [
        Text(
          '!هیچ ڕەنگێک بەردەست نییە',
          style: TextStyle(
            fontFamily: "kurdish",
          ),
        )
      ];
    }

    return productColors.split('-').map((colorName) {
      bool isSelected = selectedColor == colorName.trim();
      return GestureDetector(
        onTap: () {
          setState(() {
            selectedColor = colorName.trim();
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Container(
            width: 25.0,
            height: 25.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _getColorFromName(colorName.trim()),
              border: isSelected
                  ? Border.all(color: Colors.black, width: 2.0)
                  : null,
            ),
          ),
        ),
      );
    }).toList();
  }

  Color _getColorFromName(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'blue.shade900':
        return Colors.blue.shade900;
      case 'green':
        return Colors.green;
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'yellow':
        return Colors.yellow;
      case 'orange':
        return Colors.orange;
      case 'purple':
        return Colors.purple;
      case 'brown':
        return Colors.brown;
      default:
        return Colors.grey;
    }
  }
}
