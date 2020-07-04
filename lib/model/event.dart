import 'package:firebase_helpers/firebase_helpers.dart';

class EventModel extends DatabaseItem{
  final String authorName;
  final String title, imgURL;
  final String description;
  final DateTime date;

  EventModel({this.authorName,this.title, this.description, this.date, this.imgURL}):super(authorName);

  factory EventModel.fromMap(Map data) {
    return EventModel(
      imgURL: data['imgURL'],
      title: data['title'],
      description: data['description'],
      date: data['date'],
    );
  }

  factory EventModel.fromDS(String id, Map<String,dynamic> data) {
    return EventModel(
      authorName: data['authorName'],
      title: data['title'],
      imgURL: data['imgURL'],
      description: data['description'],
      date: data['date'].toDate(),
    );
  }

  Map<String,dynamic> toMap() {
    return {
      "imgURL": imgURL,
      "title":title,
      "description": description,
      "date": date,
      "authorName": authorName,
    };
  }
}