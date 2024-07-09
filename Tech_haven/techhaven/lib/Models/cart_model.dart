class CartItem {
  final String productName;
  final double productPrice;
  final String productSize;
  final String productImage;
  int quantity;

  CartItem({
    required this.productName,
    required this.productPrice,
    required this.productSize,
    required this.productImage,
    this.quantity = 1,
  });

  Map<String, dynamic> toJson() => {
        'productName': productName,
        'productPrice': productPrice,
        'productSize': productSize,
        'productImage': productImage,
        'quantity': quantity,
      };

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productName: json['productName'],
      productPrice: json['productPrice'],
      productSize: json['productSize'],
      productImage: json['productImage'],
      quantity: json['quantity'] ?? 1,
    );
  }
}
