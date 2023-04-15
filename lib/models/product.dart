import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

enum ProductSaleStatus { pending, sold, active, inactive }

@JsonSerializable()
class Product {
  String? id;
  String name;
  String ownerId;
  ProductSaleStatus productStatus;
  DateTime dateCreated;
  List<String> imagePaths;

  Product({required this.name, required this.dateCreated, required this.imagePaths, required this.ownerId, required this.productStatus});

  factory Product.fromJson(Map<String, dynamic> data, String? id) {
    return _$ProductFromJson(data)..id = id;
  }
  toJson() {
    return _$ProductToJson(this);
  }
}
