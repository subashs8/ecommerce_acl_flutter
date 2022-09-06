// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

List<Products> productsFromJson(String str) => List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
  Products({
    this.id,
    this.productName,
    this.description,
    this.productType,
    this.price,
    this.discount,
  });

  String? id;
  String? productName;
  String? description;
  String? productType;
  int? price;
  bool? discount;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    id: json["_id"],
    productName: json["productName"],
    description: json["description"],
    productType: json["productType"],
    price: json["price"],
    discount: json["discount"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "productName": productName,
    "description": description,
    "productType": productType,
    "price": price,
    "discount": discount,
  };
}
