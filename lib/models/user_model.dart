import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

 class UserModel {

  final String uid;
 final String firstName;
 final String lastName;
 final String college;
 final String location;
 final String email;

 UserModel(this.uid, {
  required this.firstName,
  required this.lastName,
  required this.college,
  required this.location,
  required this.email,
  required this.uid,
 });

 factory UserModel.fromDocument(DocumentSnapshot doc){
  return UserModel(
      uid: doc.data()['uid'],
      firstName: doc.data()['first name'],
      lastName: doc.data()['last name'],
      college: doc.data()['college'],
      location: doc.data()['location'],
      email: doc.data()['email']
  );
 }

}