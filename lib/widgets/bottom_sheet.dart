import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_register/helpers/shared.dart';
import 'package:personal_register/helpers/strings.dart';
import 'package:personal_register/models/month/month.dart';
import 'package:personal_register/models/month/month_manager.dart';
import 'package:personal_register/models/register/register.dart';
import 'package:personal_register/models/register/register_manager.dart';
import 'package:personal_register/models/user/user_manager.dart';
import 'package:personal_register/widgets/default_container.dart';
import 'package:provider/provider.dart';
import 'package:brasil_fields/brasil_fields.dart';

class CustomBottomSheet extends StatefulWidget {
  final Month month;

  CustomBottomSheet({Key key, this.month}) : super(key: key);

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final Register register = new Register();

  final TextEditingController clientName = new TextEditingController();

  final TextEditingController clientDocNumber = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _key,
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: new BoxDecoration(
          color: Shared.standardBackgroundColor,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(10),
            topRight: const Radius.circular(10),
          ),
        ),
        child: Consumer3<RegisterManager, MonthManager, UserManager>(
            builder: (_, registerManager, monthManager, userManager, __) {
          return Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: IconButton(
                      icon: Icon(
                        Icons.remove,
                        size: 40,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    Strings.BOTTOM_SHEET_TITLE,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DefaultContainer(
                    color: Colors.white,
                    child: TextFormField(
                      enabled: !registerManager.loading,
                      controller: clientName,
                      style: TextStyle(color: Shared.standardBackgroundColor),
                      onSaved: (client) => register.clientName = client,
                      cursorColor: Colors.black,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: Shared.standardBackgroundColor,
                          ),
                          hintText: Strings.NAME_HINT,
                          hintStyle: TextStyle(
                            color: Shared.standardBackgroundColor,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DefaultContainer(
                    color: Colors.white,
                    child: TextFormField(
                      enabled: !registerManager.loading,
                      controller: clientDocNumber,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CpfInputFormatter(),
                      ],
                      style: TextStyle(color: Shared.standardBackgroundColor),
                      keyboardType: TextInputType.number,
                      onSaved: (doc) => register.docNumber = doc,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.credit_card_rounded,
                            color: Shared.standardBackgroundColor,
                          ),
                          hintText: Strings.DOC_HINT,
                          hintStyle: TextStyle(
                            color: Shared.standardBackgroundColor,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                  Container(
                    height: size.width / 7.2,
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: RaisedButton(
                      color: Shared.standardBackgroundColor.withAlpha(100),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(29)),
                      child: registerManager.loading
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                              strokeWidth: 5,
                            )
                          : Text(
                              Strings.SAVE_REGISTER_BUTTON,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                      onPressed: registerManager.loading
                          ? null
                          : () {
                              if (_key.currentState.validate()) {
                                _key.currentState.save();
                                registerManager.save(
                                    monthId: widget.month.id,
                                    monthOrder: widget.month.order,
                                    userId: userManager.user.id,
                                    register: register,
                                    onSuccess: () {
                                      debugPrint('sucesso');
                                      Navigator.of(context).pop();
                                    },
                                    onFail: (e) {
                                      SnackBar(
                                        content: Row(
                                          children: [
                                            Icon(Icons.error),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text('$e')
                                          ],
                                        ),
                                      );
                                    });
                              }
                            },
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
