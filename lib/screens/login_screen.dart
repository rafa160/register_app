import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:personal_register/helpers/shared.dart';
import 'package:personal_register/helpers/strings.dart';
import 'package:personal_register/models/user.dart';
import 'package:personal_register/models/user/user_manager.dart';
import 'package:personal_register/screens/home/home_screen.dart';
import 'package:personal_register/screens/signup_screen.dart';
import 'package:personal_register/screens/tour/tour_screen_body.dart';
import 'package:personal_register/widgets/background_one.dart';
import 'package:personal_register/widgets/default_container.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
          child: BackgroundOne(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Consumer<UserManager>(
                builder: (_, userManager, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        width: size.width * 1,
                        height: size.height * 0.3,
                      ),
                      Padding(
                        padding: EdgeInsets.only( bottom: 10),
                        child: DefaultContainer(
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            controller: email,
                            enabled: !userManager.loading,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                hintText: Strings.EMAIL_HINT,
                                hintStyle: TextStyle(color: Colors.white),
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
                          controller: password,
                          keyboardType: TextInputType.number,
                          buildCounter: (BuildContext context,
                                  {int currentLength,
                                  int maxLength,
                                  bool isFocused}) =>
                              null,
                          obscureText: true,
                          cursorColor: Colors.white,
                          maxLength: 6,
                          decoration: InputDecoration(
                              counterText: '',
                              icon: Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                              hintText: Strings.PASSWORD_HINT,
                              hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none),
                        )),
                      ),
                      Container(
                        height: size.width / 7.2,
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 15,
                          child: RaisedButton(
                            color: Shared.standardBackgroundColor,
                            textColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(29)),
                            onPressed: userManager.loading
                                ? null
                                : () {
                                    if (_key.currentState.validate()) {
                                      userManager.signIn(
                                          user: User(
                                              email: email.text,
                                              password: password.text),
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
                                          },
                                          onSucess: () {
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
                                          });
                                    }
                                  },
                            child: userManager.loading
                                ? CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                    strokeWidth: 5,
                                  )
                                : Text(
                                    Strings.LOGIN_BUTTON,
                                    style: TextStyle(fontSize: 18),
                                  ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => SignUpScreen()));
                            },
                            child: Text(
                              Strings.SIGN_UP_ACCESS,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ),
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
