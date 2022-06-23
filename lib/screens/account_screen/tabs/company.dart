import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../model/user_model.dart';

class account_details_company extends StatefulWidget {
  const account_details_company({Key? key}) : super(key: key);

  @override
  State<account_details_company> createState() => _account_details_companyState();
}

class _account_details_companyState extends State<account_details_company> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override

  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
              children:[
                // Date Joined Company
                Container(
                  padding: EdgeInsets.only(top: 40, left: 20),
                  child: Text("DATE JOINED COMPANY",style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.only(top: 40, left: 30),
                  child: Text(" ${loggedInUser.DOB}"),
                    // child: Text(" null"),
                ),
                      Container(
                padding: EdgeInsets.only(top: 40, left: 70),

              )
              ]
          ),

          // Role
          Row(
              children:[
                Container(
                  padding: EdgeInsets.only(top: 40, left: 20),
                  child: Text("ROLE",style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.only(top: 40, left: 30),
                  child: Text(" ${loggedInUser.role}"),
                    // child: Text(" driver"),
                ),
                      Container(
                padding: EdgeInsets.only(top: 40, left: 180),

              )
              ]
          ),

          // Employee ID
          Row(
              children:[
                Container(
                  padding: EdgeInsets.only(top: 40, left: 20),
                  child: Text("EMPLOYEE ID",style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.only(top: 40, left: 30),
                  child: Text(" ${loggedInUser.employmentid}"),
                    // child: Text("1212wusw"),
                ),
              ]
          ),

          // Email
          Row(
              children:[
                Container(
                  padding: EdgeInsets.only(top: 40, left: 20),
                  child: Text("EMAIL",style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.only(top: 40, left: 30),
                  child: Text(" ${loggedInUser.email}"),
                ),
                      Container(
                padding: EdgeInsets.only(top: 40, left: 60),

              )
              ]
          ),
        ],
      ),
    );
  }
}
