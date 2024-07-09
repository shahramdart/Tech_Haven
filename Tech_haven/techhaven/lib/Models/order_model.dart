// ignore_for_file: non_constant_identifier_names

import 'package:techhaven/Models/cart_model.dart';

class Order {
  final String city;
  final String town;
  final String address;
  final String phoneNumber;
  final String comment;
  final double total_price;
  final List<CartItem> items;

  Order({
    required this.city,
    required this.town,
    required this.address,
    required this.phoneNumber,
    required this.comment,
    required this.total_price,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'town': town,
      'address': address,
      'phoneNumber': phoneNumber,
      'comment': comment,
      'total_price': total_price,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}
