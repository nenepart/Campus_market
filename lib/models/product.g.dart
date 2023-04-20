// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String?,
      name: json['name'] as String,
      dateCreated: DateTime.parse(json['dateCreated'] as String),
      imagePaths: (json['imagePaths'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      ownerId: json['ownerId'] as String,
      productStatus:
          $enumDecode(_$ProductSaleStatusEnumMap, json['productStatus']),
      description: json['description'] as String,
      type: $enumDecode(_$ProductTypeEnumMap, json['type']),
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'ownerId': instance.ownerId,
      'type': _$ProductTypeEnumMap[instance.type]!,
      'productStatus': _$ProductSaleStatusEnumMap[instance.productStatus]!,
      'dateCreated': instance.dateCreated.toIso8601String(),
      'imagePaths': instance.imagePaths,
      'price': instance.price,
    };

const _$ProductSaleStatusEnumMap = {
  ProductSaleStatus.pending: 'pending',
  ProductSaleStatus.sold: 'sold',
  ProductSaleStatus.active: 'active',
  ProductSaleStatus.inactive: 'inactive',
};

const _$ProductTypeEnumMap = {
  ProductType.car: 'car',
  ProductType.book: 'book',
  ProductType.appliance: 'appliance',
  ProductType.electronics: 'electronics',
  ProductType.fashion: 'fashion',
};
