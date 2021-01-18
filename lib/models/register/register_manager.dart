import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:personal_register/models/register/register.dart';
import 'package:personal_register/models/user.dart';

class RegisterManager extends ChangeNotifier {
  // RegisterManager(){
  //   // _listenClients();
  // }
  List<Register> registers = [];

  User user;
  Register register;
  bool _loading = false;
  String registerMonthId;

  String _search = '';

  String get search => _search;

  List<Register> allClients = [];

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  bool isHTML = false;
  bool get loading => _loading;

  final Firestore firestore = Firestore.instance;

  StreamSubscription _streamSubscription;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }


  void updateUser(User user) {
    this.user = user;
    registers.clear();
    _streamSubscription?.cancel();
    if (user != null) {
      _listenClients();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription?.cancel();
  }


  Future<void> save({Register register, String monthId,
    String userId,int monthOrder, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      register.monthId = monthId;
      register.userId = userId;
      register.monthOrder = monthOrder;
      this.register = register;
      await register.createRegister();
      // sendEmail();
      onSuccess();
    } catch (e) {
      onFail(e);
      print(e);
    }
    loading = false;
  }

  List<Register> get filteredClients {
    final List<Register> filteredClients =[];
    if(search.isEmpty) {
      filteredClients.addAll(allClients);
    } else {
      filteredClients.addAll(allClients.where((element) => element.clientName.toLowerCase().contains(search.toLowerCase())));
    }

    return filteredClients;

  }

  void _listenClients() {
    _streamSubscription = firestore.collection('clients').where('user_id', isEqualTo: user.id).snapshots().listen((event) {
      allClients.clear();
      for(final doc in event.documents){
       allClients.add(Register.fromDocument(doc));
      }
    });
  }

  void listenToRegisters(String id){
    _streamSubscription = firestore.collection('months').document(id).collection('register').where('user_id', isEqualTo: user.id).snapshots().listen((event) {
      registers.clear();
      for(final doc in event.documents) {
        registers.add(Register.fromDocument(doc));
      }
      notifyListeners();
    });
  }

  List<Register> get filtered {
    final List<Register> filtered =[];
    if(search.isEmpty) {
      filtered.addAll(registers);
    } else {
      filtered.addAll(registers.where((element) => register.clientName.toLowerCase().contains(search.toLowerCase())));
    }
  }


  Future<void> sendEmail() async {
    final Email email = Email(
      body: 'Registro do cliente ' + register.clientName + ' criado com sucesso.',
      subject: 'Entrada',
      recipients: [user.email],
      isHTML: isHTML,
    );
    String platformResponse;
    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (e){
      platformResponse = e.toString();
    }
  }



}
