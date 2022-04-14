import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../model/user_model.dart';

class account_details_personal extends StatefulWidget {
  const account_details_personal({Key? key}) : super(key: key);

  @override
  State<account_details_personal> createState() => _account_details_personalState();
}

class _account_details_personalState extends State<account_details_personal> {

  final _formKey = GlobalKey<FormState>();

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  final currentUser = FirebaseAuth.instance.currentUser;
  final  usersRef = FirebaseFirestore.instance.collection('users');

  bool _displayHandphoneNumberNoValid = true;

  TextEditingController changePhoneNumberController = TextEditingController();

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
    // Handphone Number
    handphone_number(BuildContext context) {
      return showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text("Update Mobile Number"),
          content: TextField(
            decoration: InputDecoration(
                hintText: "New Handphone Number"
            ),
            controller: changePhoneNumberController,
            keyboardType: TextInputType.phone,
          ),
          actions: [
            ElevatedButton.icon(
              onPressed: () {Navigator.of(context).pop(context);},
              icon: Icon(Icons.cancel),
              label: Text(
                "Cancel",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Color(0xffDC3545),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {Navigator.of(context).pop(context);},
              icon: Icon(Icons.change_circle_sharp),
              label: Text(
                "Confirm",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Color(0xff2A4D69),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
            ),
          ],
        );
      });
    }

    // Functions - Email
    email(BuildContext context) {
      TextEditingController customController = TextEditingController();
      return showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text("Update Email"),
          content: TextField(
            decoration: InputDecoration(
                hintText: "Email"
            ),
            controller: customController,
            //keyboardType: TextInputType.phone,
          ),
          actions: [
            ElevatedButton.icon(
              onPressed: () {Navigator.of(context).pop(context);},
              icon: Icon(Icons.cancel),
              label: Text(
                "Cancel",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Color(0xffDC3545),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {Navigator.of(context).pop(context);},
              icon: Icon(Icons.change_circle_sharp),
              label: Text(
                "Confirm",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Color(0xff2A4D69),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
            ),
          ],
        );
      });
    }

    // Functions - Address
    address(BuildContext context) {
      TextEditingController customController = TextEditingController();
      return showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text("Update Address"),
          content: TextField(
            decoration: InputDecoration(
                hintText: "Addresd"
            ),
            controller: customController,
            //keyboardType: TextInputType.phone,
          ),
          actions: [
            ElevatedButton.icon(
              onPressed: () {Navigator.of(context).pop(context);},
              icon: Icon(Icons.cancel),
              label: Text(
                "Cancel",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Color(0xffDC3545),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {Navigator.of(context).pop(context);},
              icon: Icon(Icons.change_circle_sharp),
              label: Text(
                "Confirm",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Color(0xff2A4D69),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
            ),
          ],
        );
      });
    }

    return Column(
      children: [

        // Name
        Row(
            children:[
              Container(
                padding: EdgeInsets.only(top: 40, left: 20),
                child: Text("NAME",style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: EdgeInsets.only(top: 40, left: 30),
                child: Text(" ${loggedInUser.name}}"),
              ),
            ]
        ),

        // Date of Birth
        Row(
            children:[
              Container(
                padding: EdgeInsets.only(top: 50, left: 20),
                child: Text("DATE OF BIRTH",style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: EdgeInsets.only(top: 50, left: 30),
                child: Text(" ${loggedInUser.DOB}"),
                // child: Text(" 2002-06-09"),
              ),
            ]
        ),

        // Mobile Number
        Row(
            children:[
              Container(
                padding: EdgeInsets.only(top: 40, left: 20),
                child: Text("MOBILE NO",style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: EdgeInsets.only(top: 40, left: 20),
                child: Text(" ${loggedInUser.phone}"),
                  // child: Text("91864138"),
              ),
              Container(
                padding: EdgeInsets.only(top: 40, left: 160),
                child: IconButton(
                  onPressed: () {
                    handphone_number(context);
                  },
                  icon: Icon(Icons.edit),
                ),
              )
            ]
        ),

        // Email
        Row(
            children:[
              Container(
                padding: EdgeInsets.only(top: 30, left: 20),
                child: Text("EMAIL",style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: EdgeInsets.only(top: 30, left: 30),
                child: Text(" ${loggedInUser.email}"),
              ),
              Container(
                padding: EdgeInsets.only(top: 30, left: 20),
                child: IconButton(
                  onPressed: () {email(context);},
                  icon: Icon(Icons.edit),
                ),
              )
            ]
        ),

        // Address
        Row(
            children:[
              Container(
                padding: EdgeInsets.only(top: 30, left: 20),
                child: Text("ADDRESS",style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: EdgeInsets.only(top: 30, left: 30),
                child: Text(" ${loggedInUser.address}"),
                  // child: Text("hwhdwdw"),
              ),
            ]
        ),

      ],
    );
  }
}
