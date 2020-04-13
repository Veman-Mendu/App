import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'firestoreListView.dart';

class Detail extends StatefulWidget {
  
  final DocumentSnapshot appartment;
  final int apparIndex;
  Detail({this.appartment,this.apparIndex});
  

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appartment.documentID),
      ),

      body: StreamBuilder(
        stream: Firestore.instance.collection("Appartments").snapshots(),
        builder: (_,snapshot){
          if(!snapshot.hasData){
            return Center(
              child: Text('Loading...'),
            );
          }
          else{
            return firestoreListView(documents: snapshot.data.documents,apparIndex: widget.apparIndex,title: widget.appartment.documentID,);
          }
        },
      ),
    );
  }
}

