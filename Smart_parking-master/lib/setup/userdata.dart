import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:smart_parking/models/user.dart';

class FirestoreService{
  final CollectionReference _usersCollectionReference = 
    Firestore.instance.collection('users');


Future createUser(User user) async{
  try{
    await _usersCollectionReference.document(user.userid).setData(user.toMap());

  }catch(e){
    if(e is PlatformException){
      return e.message;
    }
    return e.toString();
  }
}

Future<User> getUsername(String uid) async {
  try{
    var userData = await _usersCollectionReference.document(uid).get();
    return User.fromMap(userData.data);

  }catch(e){
    return e.message;

  }
}
}