import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:techhaven/Models/cart_model.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  CartProvider() {
    _loadCart();
  }

  void addItem(CartItem item) {
    _items.add(item);
    notifyListeners();
    _saveCart();
  }

  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
      _saveCart();
    }
  }

  void increaseQuantity(int index) {
    if (index >= 0 && index < _items.length) {
      _items[index].quantity++;
      notifyListeners();
      _saveCart();
    }
  }

  void decreaseQuantity(int index) {
    if (index >= 0 && index < _items.length && _items[index].quantity > 1) {
      _items[index].quantity--;
      notifyListeners();
      _saveCart();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
    _saveCart();
  }

  double get subtotal {
    double total = 0.0;
    for (var item in _items) {
      total += item.productPrice * item.quantity;
    }
    return total;
  }

  void _saveCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('cart', jsonEncode(_items));
  }

  void _loadCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartData = prefs.getString('cart');
    if (cartData != null) {
      List<dynamic> decodedData = jsonDecode(cartData);
      _items = decodedData.map((item) => CartItem.fromJson(item)).toList();
      notifyListeners();
    }
  }
}




