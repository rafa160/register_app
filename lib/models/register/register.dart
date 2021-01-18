import 'package:cloud_firestore/cloud_firestore.dart';

class Register {
  String id;
  Timestamp date;
  String userId;
  int monthOrder;
  String clientName;
  String docNumber;
  String monthId;

  Register(
      {this.id,
      this.date,
      this.clientName,
      this.docNumber,
      this.monthOrder,
      this.monthId,
      this.userId});

  final Firestore firestore = Firestore.instance;

  DocumentReference get firestoreRef =>
      Firestore.instance.document('months/$monthId');

  CollectionReference get registerReference =>
      firestoreRef.collection('register');


  Future<void> createRegister() async {
    await registerReference.add({
      'created_at': Timestamp.now(),
      'client_name': clientName,
      'doc_number': docNumber,
      'month_order': monthOrder,
      'user_id': userId
    });
    await firestore.collection('clients').document(id).setData({
      'created_at': Timestamp.now(),
      'client_name': clientName,
      'doc_number': docNumber,
      'month_order': monthOrder,
      'user_id': userId
    });
  }

  String getDate() {
    DateTime now = DateTime.now();
    return now.toString();
  }

  Register.fromDocument(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.documentID;
    date = documentSnapshot['created_at'] as Timestamp;
    clientName = documentSnapshot['client_name'] as String;
    docNumber = documentSnapshot['doc_number'] as String;
    monthOrder = documentSnapshot['month_order'] as int;
    userId = documentSnapshot['user_id'] as String;
  }


  @override
  String toString() {
    return 'Register{id: $id, date: $date, userId: $userId, monthOrder: $monthOrder, clientName: $clientName, docNumber: $docNumber, monthId: $monthId, firestore: $firestore}';
  }
}
