import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ChatModel{
  final String text;
  final DateTime  date;
  final bool isSentByMe;

  ChatModel({
    required this.text,
    required this.date,
    required this.isSentByMe,
  });

  //Map<String, dynamic> toJson(){
    //return{

    //};
  //}

  factory ChatModel.fromDocument(Map<String, dynamic> data, String? id){
    return _$ChatModelFromJson(data)..id = id;
  }
  toJson(){
    return _$ChatModelToJson(this);
  }

}