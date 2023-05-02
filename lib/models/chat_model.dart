import 'package:json_annotation/json_annotation.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel {
  String text;
  String? id;
  DateTime date;
  String userSentId;
  String productId;

  ChatModel({
    this.id,
    required this.userSentId,
    required this.text,
    required this.date,
    required this.productId,


  });

  //Map<String, dynamic> toJson(){
  //return{

  //};
  //}

  factory ChatModel.fromDocument(Map<String, dynamic> data, String? id) {
    return _$ChatModelFromJson(data)..id = id;
  }

  toJson() {
    return _$ChatModelToJson(this);
  }
}
