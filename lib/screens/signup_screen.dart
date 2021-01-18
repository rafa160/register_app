import 'package:flutter/material.dart';
import 'package:personal_register/helpers/shared.dart';
import 'package:personal_register/helpers/strings.dart';
import 'package:personal_register/models/user.dart';
import 'package:personal_register/models/user/user_manager.dart';
import 'package:personal_register/screens/home/home_screen.dart';
import 'package:personal_register/screens/tour/tour_screen_body.dart';
import 'package:personal_register/widgets/background_two.dart';
import 'package:personal_register/widgets/default_container.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final User user = new User();

  final TextEditingController email = new TextEditingController();
  final TextEditingController password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: BackgroundTwo(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Consumer<UserManager>(
                builder: (_, userManager, __){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppBar(
                        title: Text(Strings.SCREEN_SIGNUP_TITLE, style: TextStyle(color: Shared.standardBackgroundColor),),
                        backgroundColor: Colors.transparent,
                        centerTitle: true,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 110, bottom: 10),
                        child: DefaultContainer(
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            onSaved: (email) => user.email = email,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                hintText: Strings.EMAIL_HINT,
                                hintStyle: TextStyle(
                                    color: Colors.white
                                ),
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
                        child: DefaultContainer(
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              enabled: !userManager.loading,
                              onSaved: (senha) => user.password = senha,
                              keyboardType: TextInputType.number,
                              obscureText: true,
                              cursorColor: Colors.white,
                              maxLength: 6,
                              buildCounter: (BuildContext context,
                                  {int currentLength,
                                    int maxLength,
                                    bool isFocused}) =>
                              null,
                              decoration: InputDecoration(
                                  counterText: '',
                                  icon: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                  hintText: Strings.PASSWORD_HINT,
                                  hintStyle: TextStyle(
                                      color: Colors.white
                                  ),
                                  border: InputBorder.none),
                            )
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
                        child: DefaultContainer(
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              onSaved: (confirmPass) =>
                              user.confirmPassword = confirmPass,
                              enabled: !userManager.loading,
                              keyboardType: TextInputType.number,
                              obscureText: true,
                              cursorColor: Colors.white,
                              buildCounter: (BuildContext context,
                                  {int currentLength,
                                    int maxLength,
                                    bool isFocused}) =>
                              null,
                              maxLength: 6,
                              decoration: InputDecoration(
                                  counterText: '',
                                  icon: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                  hintText: Strings.PASSWORD_HINT_CONFIRMATION,
                                  hintStyle: TextStyle(
                                      color: Colors.white
                                  ),
                                  border: InputBorder.none),
                            )
                        ),
                      ),
                      Container(
                        height: size.width / 7.2,
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        child: RaisedButton(
                          disabledColor: Colors.grey,
                          color: Shared.standardBackgroundColor,
                          child: userManager.loading ? CircularProgressIndicator(
                            valueColor:
                            AlwaysStoppedAnimation(Colors.white),
                            strokeWidth: 5,
                          ) :  Text(Strings.SIGNUP_BUTTON,  style: TextStyle(fontSize: 18),),
                          textColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29)),
                          onPressed: userManager.loading
                              ? null
                              : () {
                            if (_key.currentState.validate()) {
                              _key.currentState.save();
                              if (user.password != user.confirmPassword) {
                                scaffoldKey.currentState
                                    .showSnackBar(SnackBar(
                                  content: Row(
                                    children: [
                                      Icon(Icons.error),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(Strings.PASSWORD_ERROR)
                                    ],
                                  ),
                                  backgroundColor: Colors.red,
                                ));
                                return;
                              }
                              userManager.signUp(
                                  user: user,
                                  onSuccess: () {
                                    debugPrint('sucesso');
                                    userManager.user.finishedTour ==
                                        true
                                        ? Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                HomeScreen()))
                                        : Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                TourScreenBody()));
                                  },
                                  onFail: (e) {
                                    scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Row(
                                        children: [
                                          Icon(Icons.error),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text('$e')
                                        ],
                                      ),
                                      backgroundColor: Colors.red,
                                    ));
                                  });
                            }
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

