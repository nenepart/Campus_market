// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatSession _$ChatSessionFromJson(Map<String, dynamic> json) => ChatSession(
      productId: json['productId'] as String,
      messages: (json['messages'] as List<dynamic>).map((e) => ChatModel.fromJson(e as Map<String, dynamic>)).toList(),
      productOwnerId: json['productOwnerId'] as String,
      senderId: json['senderId'] as String,
      senderName: json['senderName'] as String,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$ChatSessionToJson(ChatSession instance) => <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'productOwnerId': instance.productOwnerId,
      'senderId': instance.senderId,
      'senderName': instance.senderName,
      'messages': instance.messages.map((e) => e.toJson()),
    };
