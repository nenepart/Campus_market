// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => ChatModel(
      id: json['id'] as String?,
      userSentId: json['userSentId'] as String,
      text: json['text'] as String,
      date: DateTime.parse(json['date'] as String),
      productId: json['productId'] as String,
    );

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'text': instance.text,
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'userSentId': instance.userSentId,
      'productId': instance.productId,
    };
