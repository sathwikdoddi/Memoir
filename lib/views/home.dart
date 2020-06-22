import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:memoir_mu/services/crud.dart';
import 'package:memoir_mu/views/detail_view.dart';

import 'create_mem.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CrudMethods crudMethods = new CrudMethods();
  Stream memoirsStream;

  Widget MemoirsList() {
    return SingleChildScrollView(
      child: memoirsStream != null
          ? Column(
              children: <Widget>[
                StreamBuilder(
                  stream: memoirsStream,
                  builder: (context, snapshot) {
                    return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemCount: snapshot.data.documents.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return MemoirsCard(
                            authorName: snapshot.data.documents[index].data['authorName'],
                            title: snapshot.data.documents[index].data["title"],
                            description: snapshot.data.documents[index].data['description'],
                            imgUrl: snapshot.data.documents[index].data['imgURL'],
                          );
                        });
                  },
                )
              ],
            )
          : Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
          ),
    );
  }

  @override
  void initState() {
    super.initState();

    crudMethods.getData().then((result) {
      memoirsStream = result;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text(
            "Memoir",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          Text(
            "Mockup",
            style: TextStyle(
              fontSize: 24,
              color: Colors.grey[700]
            ),
          ),
        ]),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(child: MemoirsList()),
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CreateMemoir()));
            },
            child: Icon(Icons.note_add, color: Colors.white70),
            backgroundColor: Colors.grey[600],
          )
        ]),
      ),
    );
  }
}

class MemoirsCard extends StatelessWidget {

  String imgUrl, title, description, authorName;
  MemoirsCard({@required this.imgUrl, @required this.title, @required this.description, @required this.authorName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailMemoirView(authorName: authorName, description: description, cover: imgUrl, title: title)
          )
        );
      },
    child: Container(
      margin: EdgeInsets.only(bottom: 20),
      height: 200,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10), 
            child: imgUrl != null ? Image.network(
              imgUrl, 
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover
            )
            : Container()
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.black54.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400
                  )
                ),
              ],
            ),
          ),
        ],
      )
    ),
    );
  }
}