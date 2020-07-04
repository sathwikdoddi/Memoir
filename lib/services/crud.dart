import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:memoir_mu/model/event.dart';

class CrudMethods {

  getData({user}) async {
    return await Firestore.instance.collection(user).snapshots(); 
  }

  Future<void> addData (memoirData, user) async {
    Firestore.instance.collection(user).add(memoirData).catchError((e) {
      print(e);
    });
  }
}

DatabaseService<EventModel> eventDBS = DatabaseService<EventModel>("1@2.com",fromDS: (id,data) => EventModel.fromDS(id, data), toMap:(event) => event.toMap());