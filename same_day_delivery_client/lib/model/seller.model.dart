class Seller {
  String sellerId;
  String sellerName;
  String sellerEmail;
  String sellerPassword;
  String sellerPhone;
  String sellerAddress;
  DateTime sellerDate;

  Seller({
    required this.sellerId,
    required this.sellerName,
    required this.sellerEmail,
    required this.sellerPassword,
    required this.sellerPhone,
    required this.sellerAddress,
    required this.sellerDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'seller_id': sellerId,
      'seller_name': sellerName,
      'seller_email': sellerEmail,
      'seller_password': sellerPassword,
      'seller_phone': sellerPhone,
      'seller_address': sellerAddress,
      'seller_date': sellerDate,
    };
  }

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      sellerId: json['seller_id'],
      sellerName: json['seller_name'],
      sellerEmail: json['seller_email'],
      sellerPassword: json['seller_password'],
      sellerPhone: json['seller_phone'],
      sellerAddress: json['seller_address'],
      sellerDate: json['seller_date'],
    );
  }
}
