class ProductModel {
  String productId;
  String sellerId;
  String productName;
  num productPrice;
  String productImage;
  String productDescription;
  DateTime productDate;

  ProductModel({
    required this.productId,
    required this.sellerId,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.productDescription,
    required this.productDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'seller_id': sellerId,
      'product_name': productName,
      'product_price': productPrice,
      'product_image': productImage,
      'product_description': productDescription,
      'product_date': productDate,
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['product_id'],
      sellerId: json['seller_id'],
      productName: json['product_name'],
      productPrice: json['product_price'],
      productImage: json['product_image'],
      productDescription: json['product_description'],
      productDate: json['product_date'],
    );
  }
}
