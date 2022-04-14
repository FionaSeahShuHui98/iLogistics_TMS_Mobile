import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:i_logistics/model/call_model.dart';

class call_screen extends StatefulWidget {
  const call_screen({Key? key}) : super(key: key);

  @override
  _call_screenState createState() => _call_screenState();
}

class _call_screenState extends State<call_screen> {

  User? user = FirebaseAuth.instance.currentUser;
  CallModel call_log = CallModel();
  List callsList = [];

  @override
  void initState() {
    fetchDatabaseList();
    super.initState();
  }

  fetchDatabaseList() async{
    final calls= await  FirebaseFirestore.instance.collection('hotline').get().then((QuerySnapshot) {
      QuerySnapshot.docs.forEach((element) {
        callsList.add(element.data());
      });
       return callsList;
    });

    for(var call in calls){
      print(call);
      setState(() {
        callsList = calls;
      });
   
    }
    print(callsList);
 
    return callsList;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // Header
      appBar: AppBar(
        backgroundColor: Color(0xff2A4D69),
        title: Text("Call Hotline"),
      ),

      // Main Content
      body:
      ListView.builder(
        itemCount: callsList.length,
        itemBuilder: (context,  index) {
          return Card(
            child: ListTile(
              title: Text(callsList[index]['hotlineName']),
              trailing:
              new ElevatedButton.icon(
                icon: Icon(Icons.call),
                onPressed: () async {await FlutterPhoneDirectCaller.callNumber('${callsList[index]['hotlineNo']}');},
                label: Text("Call"),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff2A4D69),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                )
              ),
            ),
          );
        }),
      );
  }
}
