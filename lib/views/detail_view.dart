import 'package:flutter/material.dart';

class DetailMemoirView extends StatelessWidget {

  final String authorName, title, description;
  final String cover;

  const DetailMemoirView({Key key, this.authorName, this.title, this.description, this.cover}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipRRect(
              child: Image.network(cover),
              borderRadius: BorderRadius.only(bottomLeft: const Radius.circular(50)),
            ),
            SizedBox(height: 7),
            SizedBox(height: 15),
            Text (
              title,
              style: TextStyle(
                fontSize: 36,
                color: Colors.white,
                fontWeight: FontWeight.w700
              )
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 21,
                  color: Colors.white,
                  fontWeight: FontWeight.w600
                )
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 300),
                child: Text (
                "By $authorName",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}