import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Detail.dart';

class List extends StatefulWidget {
  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<List> {
  
  Future _data;

  Future getAreas() async {

    var firestore = Firestore.instance;
    QuerySnapshot query = await firestore.collection("AppartmentInfo").getDocuments();
    return query.documents;
  }

  navigateToDetail(DocumentSnapshot appartment,int index){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Detail(appartment: appartment,apparIndex: index)));
  }

  @override
  void initState() {
    super.initState();
    _data = getAreas();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _data,
        builder: (_,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: Text('Loading...'),
            );
          }
          else{
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_,index) {
                String subtitle = 'amount - ${snapshot.data[index].data['amount']}';
                return Card(
                  child: ListTile(
                    onTap: () => navigateToDetail(snapshot.data[index],index),
                    title: Text(snapshot.data[index].documentID),
                    subtitle: Text(subtitle),
                  )
                );
            });
          }
      }),
    );
  }
}