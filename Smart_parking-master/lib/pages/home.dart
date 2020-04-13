import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_parking/List.dart';
import 'package:smart_parking/Constants.dart';
import 'package:smart_parking/MessagingWidget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appartments'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (context){
              return Constants.choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: List(),
    );
  }

  void choiceAction(String choice){
    if(choice == Constants.logOut){

      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Confirm to LogOut'),
            actions: <Widget>[
              MaterialButton(
                elevation: 0.0,
                child: Text('Yes'),
                textColor: Colors.green,
                onPressed: (){
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamed('/loginPage');
                },
              ),
              MaterialButton(
                elevation: 0.0,
                child: Text('No'),
                textColor: Colors.red,
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    if(choice == Constants.notifications){
      Navigator.of(context).pushNamed('/notificationPage');
    }
    if(choice == Constants.profile){
      Navigator.of(context).pushNamed('/profilePage');
    }
  }
}