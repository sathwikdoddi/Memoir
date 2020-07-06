import 'package:flutter/material.dart';
import 'package:memoir_mu/views/calendar.dart';
import 'package:memoir_mu/views/home.dart';

class BottomNavBar extends StatelessWidget {
  final String user;
  const BottomNavBar({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      color: Colors.grey[700],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (_, a1, a2) => HomePage(user: user)));
            }
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (_, a1, a2) => CalendarView(user: user)));
            },
          )
        ],
      )
    );
  }
}