import 'package:cloud_firestore/cloud_firestore.dart';

class Month  {

  String id;
  String month;
  int order;

  Month({this.id, this.month, this.order});

  Month.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.documentID;
    month = snapshot.data['month'] ?? "";
    order = snapshot.data['order'] as int ?? 0;
  }


  DocumentReference get firestoreRef =>
      Firestore.instance.document('months/$id');

}