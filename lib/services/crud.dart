import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods {

  getData() async {
    return await Firestore.instance.collection("memoirs").snapshots(); 
  }

  Future<void> addData (memoirData) async {
    Firestore.instance.collection("memoirs").add(memoirData).catchError((e) {
      print(e);
    });
  }
}