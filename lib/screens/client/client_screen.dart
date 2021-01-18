import 'package:flutter/material.dart';
import 'package:personal_register/helpers/shared.dart';
import 'package:personal_register/models/register/register_manager.dart';
import 'package:personal_register/models/user/user_manager.dart';
import 'package:personal_register/screens/register/register_card.dart';
import 'package:personal_register/widgets/empty_screen.dart';
import 'package:personal_register/widgets/search_dialog.dart';
import 'package:provider/provider.dart';

class ClientScreen extends StatefulWidget {
  @override
  _ClientScreenState createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Shared.standardBackgroundColor,
      body: SingleChildScrollView(
        child: Consumer<RegisterManager>(
          builder: (_, registerManager,__){
            return Container(
              height: MediaQuery.of(context).size.height * 1,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppBar(
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white,),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),
                    title: Text('Clientes Cadastrados', style: TextStyle(color: Colors.white),),
                    actions: [
                      IconButton(
                          icon: Icon(Icons.search, color: Colors.white,),
                          onPressed: () async {
                            final search = await showDialog<String>(
                                context: context,
                                builder: (_) => SearchDialog(registerManager.search));
                            if(search != null)
                              registerManager.search = search;
                            else
                              return IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.black,
                                ),
                                onPressed: () async {
                                  registerManager?.search = '';
                                },
                              );
                          }
                      ),
                    ],
                  ),
                  Consumer2<RegisterManager, UserManager>(
                    builder: (_,registerManager, userManager,__){
                      userManager.isLoggedIn;
                      final filteredClients = registerManager.filteredClients;
                      if(filteredClients.isEmpty)
                        return EmptyScreen();
                      else
                        return Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: registerManager.filteredClients?.length,
                            itemBuilder: (_, index){
                              return RegisterCard(
                                register: registerManager.filteredClients[index],
                              );
                            },
                          ),
                        );
                    },),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
