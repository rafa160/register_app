import 'package:flutter/material.dart';
import 'package:personal_register/helpers/shared.dart';
import 'package:personal_register/models/month/month_manager.dart';
import 'package:personal_register/models/register/register_manager.dart';
import 'package:personal_register/models/user/user_manager.dart';
import 'package:personal_register/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp(
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => MonthManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, RegisterManager>(
            create: (_) => RegisterManager(),
            lazy: false,
            update: (_, userManager,registerManager) => registerManager..updateUser(userManager.user),
        ),
      ],
      child: MaterialApp(
        title: 'Register App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
            // shadowColor: Colors.white,
            hoverColor: Colors.white,
            appBarTheme: AppBarTheme(
                color: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                iconTheme: IconThemeData(color: Shared.standardBackgroundColor))),
        home: Consumer2<UserManager, RegisterManager>(
          builder: (_, userManager,registerManager,__) {
            // Future.delayed(Duration(seconds: 10));
            // if(userManager.loading)
            //   return SplashScreen();
            // else if (userManager.isLoggedIn)
              return HomeScreen();
            // else
            //   return LoginScreen();
          },
        ),
      ),
    );
  }
}
