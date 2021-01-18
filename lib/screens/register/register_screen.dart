import 'package:flutter/material.dart';
import 'package:personal_register/helpers/shared.dart';
import 'package:personal_register/helpers/strings.dart';
import 'package:personal_register/models/month/month.dart';
import 'package:personal_register/models/register/register.dart';
import 'package:personal_register/models/register/register_manager.dart';
import 'package:personal_register/screens/register/register_card.dart';
import 'package:personal_register/widgets/bottom_sheet.dart';
import 'package:personal_register/widgets/empty_screen.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  final Month month;
  final Register register;

  const RegisterScreen({this.month, this.register});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterManager registerManager;
  @override
  void initState() {
    super.initState();
    registerManager?.listenToRegisters(widget.month.id);
  }

  @override
  Widget build(BuildContext context) {
    bool compareDates(Month month) {
      DateTime now = DateTime.now();
      now.month;
      if (now.month == month.order)
        return true;
      else
        return false;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10,bottom: 60),
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppBar(
                title: Text(widget.month.month, style: TextStyle(color: Shared.standardBackgroundColor, fontWeight: FontWeight.bold),),
              ),
              Consumer<RegisterManager>(
                builder: (_, registerManager, __) {
                  registerManager.listenToRegisters(widget.month.id);
                    if (registerManager.user == null) {
                      return Container(
                        child: Center(
                          child: Text(Strings.USER_NULL),
                        ),
                      );
                    }
                    if (registerManager.registers.isEmpty) {
                      return EmptyScreen();
                    }
                    if(registerManager.loading){
                      return Center(child: CircularProgressIndicator());
                    }
                    return  Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: registerManager.registers?.length,
                          itemBuilder: (_, index) {
                            return RegisterCard(
                              register: registerManager.registers[index],
                            );
                          },
                      ),
                    );
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: compareDates(widget.month)
          ? FloatingActionButton.extended(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext bc) => CustomBottomSheet(
                    month: widget.month,
                  ),
                );
              },
              label: Text(Strings.REGISTER_BUTTON),
              icon: Icon(Icons.person),
              backgroundColor: Shared.standardBackgroundColor,
            )
          : FloatingActionButton.extended(
              label: Text(Strings.REGISTER_NOT_ALLOWED),
              icon: Icon(Icons.no_encryption_gmailerrorred_sharp),
              backgroundColor: Colors.redAccent, onPressed: () {},),
    );
  }


}
