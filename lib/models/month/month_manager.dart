import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:personal_register/models/month/month.dart';

class MonthManager extends ChangeNotifier {
  MonthManager() {
    _loadAllMonths();
  }

  final Firestore firestore = Firestore.instance;

  String _search = '';

  String get search => _search;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Month> allMonths = [];

  bool loading;

  List<Month> get filteredMonths {
    final List<Month> filteredMonths = [];
    if(search.isEmpty) {
      filteredMonths.addAll(allMonths);
    } else {
      filteredMonths.addAll(allMonths.where((month) => month.month.toLowerCase().contains(search.toLowerCase())));
    }
    return filteredMonths;
  }

  Future<void> _loadAllMonths() async {
    loading = true;
    final QuerySnapshot snapshot =
    await firestore.collection('months').orderBy('order').getDocuments();

    allMonths = snapshot.documents
        .map((doc) => Month.fromDocument(doc))
        .toList();

    loading = false;
    notifyListeners();
  }



}
