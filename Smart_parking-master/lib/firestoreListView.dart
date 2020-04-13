import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class firestoreListView extends StatelessWidget{
  final List<DocumentSnapshot> documents;
  final int apparIndex;
  final String title;
  firestoreListView({this.documents,this.apparIndex,this.title});

  @override
  Widget build(_){
    List dataList = [documents[apparIndex].data['Slot0'],documents[apparIndex].data['Slot1'],documents[apparIndex].data['Slot2'],documents[apparIndex].data['Slot3'],documents[apparIndex].data['Slot4'],documents[apparIndex].data['Slot5']];
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: dataList.length,
      itemBuilder: (_,index){
          //List dataList = [documents[apparIndex].data['Slot0'],documents[apparIndex].data['Slot1'],documents[apparIndex].data['Slot2'],documents[apparIndex].data['Slot3'],documents[apparIndex].data['Slot4'],documents[apparIndex].data['Slot5']];
            if(dataList[index] == 'booked'){
              return Card(
                color: Colors.red,
                child: ListTile(
                  title: Text('Slot$index'),
                  subtitle: Text(dataList[index]),
                  onTap: (){
                    showDialog(
                      context: _,
                      builder: (_){
                        return AlertDialog(
                          title: Text('Confirm to Cancel'),
                          actions: <Widget>[
                            MaterialButton(
                              elevation: 0.0,
                              child: Text('Yes'),
                              textColor: Colors.green,
                              onPressed: (){

                                Firestore.instance.runTransaction((Transaction transaction) async {
                                  DocumentSnapshot snapshot = await transaction.get(documents[apparIndex].reference);

                                  await transaction.update(snapshot.reference, {'Slot$index':'free'});

                                  FirebaseUser user = await FirebaseAuth.instance.currentUser();
                                  String uid = user.uid;

                                  Firestore.instance.collection("notifications").document('$uid - Cancelation').setData({"uid": uid,"title": 'Caneled',"Message": 'Booking at $title - Slot$index is Canceled'});
                                });
                                Navigator.of(_).pop();
                              },
                            ),
                            MaterialButton(
                              elevation: 0.0,
                              child: Text('No'),
                              textColor: Colors.red,
                              onPressed: (){
                                Navigator.of(_).pop();
                              },
                            ),
                          ],
                        );
                      }
                    );
                  },
                ),
              );
            }
            else{
              return Card(
                color: Colors.green,
                child: ListTile(
                  title: Text('Slot$index'),
                  subtitle: Text(dataList[index]),
                  onTap: (){
                    showDialog(
                      context: _,
                      builder: (_){
                        return AlertDialog(
                          title: Text('Confirm to Book'),
                          actions: <Widget>[
                            MaterialButton(
                              elevation: 0.0,
                              child: Text('Yes'),
                              textColor: Colors.green,
                              onPressed: ()async{
                                  Firestore.instance.runTransaction((Transaction transaction) async {
                                  DocumentSnapshot snapshot = await transaction.get(documents[apparIndex].reference);

                                  await transaction.update(snapshot.reference, {'Slot$index':'booked'});
                                  });
                                  Navigator.of(_).pop();

                                  FirebaseUser user = await FirebaseAuth.instance.currentUser();
                                  String uid = user.uid;

                                  Firestore.instance.collection("notifications").document('$uid - Booking').setData({"uid": uid,"title": 'Booked',"Message": 'Booking at $title - Slot$index is Confirmed'});
                              },
                            ),
                            MaterialButton(
                              elevation: 0.0,
                              child: Text('No'),
                              textColor: Colors.red,
                              onPressed: (){
                                Navigator.of(_).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              );
            }
      }
    );
  }
}

