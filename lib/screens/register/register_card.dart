import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:personal_register/helpers/shared.dart';
import 'package:personal_register/helpers/strings.dart';
import 'package:personal_register/models/register/register.dart';


class RegisterCard extends StatelessWidget {

  final Register register;

  const RegisterCard({this.register});

  @override
  Widget build(BuildContext context) {

    String _cpfFormatter(String cpf) {
      var cpfFormatter =
      new MaskedTextController(text: cpf, mask: '***.***.***-00');
      cpfFormatter.updateText(cpf);
      return cpfFormatter.text;
    }

    return Card(
      elevation: 4,
      color: Shared.standardDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29)),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.14,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(Strings.CARD_USER_NAME + register.clientName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(Strings.CPF + _cpfFormatter(register.docNumber), style: TextStyle(fontSize: 15, color: Colors.white),),
                  SizedBox(
                    width: 20,
                  ),
                  Text(Strings.DAY_CARD + register.date.toDate().day.toString() +'/' +register.date.toDate().month.toString() + '/' + register.date.toDate().year.toString(), style: TextStyle(fontSize: 15, color: Colors.white),)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
