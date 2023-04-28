import 'package:json_annotation/json_annotation.dart';

import 'chat_model.dart';

part 'chat_session.g.dart';

@JsonSerializable()
class ChatSession {
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? id;
  String productId;
  String productOwnerId;
  String productOwnerName;
  String senderId;
  String senderName;
  List<ChatModel> messages;

  ChatSession(
      {required this.productId,
      required this.messages,
      required this.productOwnerId,
      required this.productOwnerName,
      required this.senderId,
      required this.senderName,
      this.id});

  factory ChatSession.fromJson(Map<String, dynamic> json, {String? id}) => _$ChatSessionFromJson(json)..id = id;

  Map<String, dynamic> toJson() => _$ChatSessionToJson(this);
  @override
  String toString() => "ChatSession";
}
