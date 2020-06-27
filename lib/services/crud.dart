import 'package:cloud_firestore/cloud_firestore.dart';

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