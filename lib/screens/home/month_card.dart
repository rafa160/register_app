import 'package:flutter/material.dart';
import 'package:personal_register/helpers/shared.dart';
import 'package:personal_register/models/month/month.dart';

class MonthCard extends StatelessWidget {

  final Month month;

  const MonthCard({this.month});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        child: Card(
          color: Colors.white,
          elevation: 4,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 1,
                width: 20,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Shared.standardBackgroundColor,
                        Colors.grey,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter
                  ),
                ),
              ),
              Positioned(
                right:20,
                  bottom: 20,
                  child: Text(
                      month.month,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Shared.standardBackgroundColor
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
