import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class User {

  String id;
  String email;
  String phone;
  String password;
  String confirmPassword;
  bool finishedTour;

  User({this.email, this.password, this.id, this.finishedTour = false});


  User.fromDocument(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.documentID;
    email = documentSnapshot.data['email'] as String;
    phone = documentSnapshot.data['phone'] as String;
    finishedTour = documentSnapshot.data['finished_tour'] as bool;
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'finished_tour': finishedTour,
      'phone': phone,
    };
  }

  Future<void> saveData() async {
    await firestoreRef.setData(toMap());
  }

  DocumentReference get firestoreRef =>
      Firestore.instance.document('users/$id');

  CollectionReference get tokensReference => firestoreRef.collection('tokens');

  Future<void> saveToken() async {
    final token = await FirebaseMessaging().getToken();
    tokensReference.document(token).setData({
      'token': token,
      'updatedAt': FieldValue.serverTimestamp(),
      'platform': Platform.operatingSystem,
    });
  }
}