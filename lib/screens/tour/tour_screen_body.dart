import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:personal_register/helpers/shared.dart';
import 'package:personal_register/models/user/user_manager.dart';
import 'package:personal_register/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class TourScreenBody extends StatefulWidget {
  @override
  _TourScreenBodyState createState() => _TourScreenBodyState();
}

class _TourScreenBodyState extends State<TourScreenBody> {
  int currentPage = 0;
  List<Map<String, String>> tourData = [
    {
      'text':
          'Bem vindo ao Register App, cadastrar entradas em seu local sem papel.',
      'image': 'assets/tour1.png',
    },
    {
      'text':
      'Ideal para condomínios, escritórios ou qualquer local que precise de um controle de documentações para entrada.',
      'image': 'assets/image2.png',
    },
    {
      'text':
          'Com apenas poucos cliques, você cadastra nome e documento em um local seguro.',
      'image': 'assets/tour2.png',

    }
  ];

  // AnimationController _animationController;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _animationController = AnimationController(
  //     vsync: this,
  //       duration: Duration(seconds: 2)
  //   );
  //
  //   _animationController.addStatusListener((status){
  //     if(status == AnimationStatus.completed){
  //       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      child: Container(
        padding: EdgeInsets.only(top: 50, left: 20, right: 20),
        color: Colors.white,
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Register App',
                  style: TextStyle(
                      color: Shared.standardBackgroundColor,
                      fontSize: MediaQuery.of(context).size.height * 0.05),
                ),
                Expanded(
                  flex: 3,
                  child: PageView.builder(
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemCount: tourData.length,
                    itemBuilder: (context, index) => TourContainer(
                      text: tourData[index]['text'],
                      image: tourData[index]['image'],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            tourData.length, (index) => buildDot(index: index)),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Consumer<UserManager>(
                        builder: (_, userManager,__){
                          return Container(
                            height: size.width / 7.2,
                            margin: const EdgeInsets.symmetric(vertical: 12),
                            child: RaisedButton(
                              disabledColor: Colors.grey,
                              color: Shared.standardBackgroundColor,
                              child: Text('continuar'),
                              textColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29)),
                              onPressed: currentPage == 2 ?(){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                              } : null,
                            ),
                          );
                        },
                      ),
                      // AnimationButton(
                      //   controller: _animationController.view,
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      margin: EdgeInsets.only(right: 2),
      height: 6,
      width: currentPage == index ? 15 : 6,
      decoration: BoxDecoration(
        color: currentPage == index
            ? Shared.standardBackgroundColor
            : Shared.standardBackgroundColor.withAlpha(100),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class TourContainer extends StatelessWidget {
  final String image, text;

  const TourContainer({Key key, this.image, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Text(
          text,
          style: TextStyle(color: Colors.grey, fontSize: 15),
          textAlign: TextAlign.center,
        ),

        Image.asset(
          image,
          height: MediaQuery.of(context).size.width * 0.6,
        ),
      ],
    );
  }
}
