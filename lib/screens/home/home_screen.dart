import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:personal_register/helpers/shared.dart';
import 'package:personal_register/helpers/strings.dart';
import 'package:personal_register/models/month/month_manager.dart';
import 'package:personal_register/models/user/user_manager.dart';
import 'package:personal_register/screens/client/client_screen.dart';
import 'package:personal_register/screens/home/month_card.dart';
import 'package:personal_register/screens/login_screen.dart';
import 'package:personal_register/screens/register/register_screen.dart';
import 'package:personal_register/screens/signup_screen.dart';
import 'package:personal_register/widgets/main_screen_placeholder.dart';
import 'package:personal_register/widgets/search_dialog.dart';
import 'package:personal_register/widgets/user_card.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserManager>(
      builder: (_, userManager, __) {
        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (BuildContext bc) => Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(10),
                      topRight: const Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    children: [
                      UserCard(
                        email: userManager.user?.email ?? Strings.SIGN_UP_MESSAGE,
                        textFirstButton: userManager.user?.email == null ? Strings.SIGNUP_BUTTON : Strings.CLIENTS_REGISTERS,
                        textSecondButton: userManager.user?.id == null ? Strings.LOGIN_BUTTON : Strings.LOGOUT,
                        onTap: () {
                          if (userManager.isLoggedIn) {
                            userManager.signOut();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => LoginScreen()));
                          } else {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => LoginScreen()));
                          }
                        },
                        userScreenOnTap: userManager.user == null ? () =>
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SignUpScreen())) : () =>
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ClientScreen())),
                      ),
                    ],
                  ),
                ),
              );
            },
            label: Text(Strings.ACCOUNT_BUTTON),
            icon: Icon(Icons.person),
            backgroundColor: Shared.standardBackgroundColor,
          ),
          backgroundColor: Shared.standardBackgroundColor,
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              height: MediaQuery.of(context).size.height * 0.95,
              child: Consumer<MonthManager>(
                builder: (_, monthManager, __) {
                  final months = monthManager.filteredMonths;
                  if (monthManager.loading)
                    return MainScreenPlaceholder();
                  else
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppBar(
                          leading: IconButton(
                            icon: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              final search = await showDialog<String>(
                                  context: context,
                                  builder: (_) =>
                                      SearchDialog(monthManager.search));
                              if (search != null) {
                                monthManager.search = search;
                              } else {
                                return IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.black,
                                  ),
                                  onPressed: () async {
                                    monthManager.search = '';
                                  },
                                );
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: StaggeredGridView.countBuilder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            crossAxisCount: 4,
                            itemCount: monthManager.filteredMonths.length,
                            itemBuilder: (_, index) {
                              return GestureDetector(
                                onTap: userManager.user == null ? (){} : () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => RegisterScreen(
                                                month: months[index],
                                              )));
                                },
                                child: MonthCard(
                                  month: months[index],
                                ),
                              );
                            },
                            staggeredTileBuilder: (index) =>
                                StaggeredTile.count(
                                    2, index.isEven ? 1.9 : 1.4),
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                          ),
                        ),
                      ],
                    );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
