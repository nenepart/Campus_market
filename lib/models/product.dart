import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

enum ProductSaleStatus { pending, sold, active, inactive }

enum ProductType { car, book, appliance, electronics, fashion }

@JsonSerializable()
class Product {
  String? id;
  String name;
  String description;
  String ownerId;
  ProductType type;
  ProductSaleStatus productStatus;
  DateTime dateCreated;
  List<String> imagePaths;
  double price;

  Product(
      {this.id,
      required this.name,
      required this.dateCreated,
      required this.imagePaths,
      required this.ownerId,
      required this.productStatus,
      required this.description,
      required this.type,
      required this.price});

  factory Product.fromJson(Map<String, dynamic> data, String? id) {
    return _$ProductFromJson(data)..id = id;
  }
  toJson() {
    return _$ProductToJson(this);
  }
}
