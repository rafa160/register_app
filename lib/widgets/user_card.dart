import 'package:flutter/material.dart';
import 'package:personal_register/helpers/shared.dart';

class UserCard extends StatelessWidget {
  final String email;
  final String textFirstButton;
  final String textSecondButton;
  final VoidCallback onTap;
  final VoidCallback userScreenOnTap;
  final VoidCallback userNullTap;

  const UserCard({this.email, this.onTap, this.userScreenOnTap,this.userNullTap, this.textFirstButton, this.textSecondButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                IconButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                    color: Shared.standardBackgroundColor,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
                Text('menu', style: TextStyle(fontSize: 20, color: Shared.standardBackgroundColor, fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                email,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Shared.standardBackgroundColor,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Center(
              child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.9,
            margin: const EdgeInsets.symmetric(vertical: 12),
                child: RaisedButton(
                  color: Shared.standardBackgroundColor,
                  child: Text(
                    textFirstButton,
                    style: TextStyle(
                        fontSize: 20, color: Colors.white),
                  ),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(29)),
                  onPressed: userScreenOnTap,
                ),
          )),
          Center(
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.9,
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: RaisedButton(
                child: Text(
                  textSecondButton,
                  style: TextStyle(
                      fontSize: 20, color: Shared.standardBackgroundColor),
                ),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(29)),
                onPressed: onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
