import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../model/user_model.dart';

class account_details_vehicle extends StatefulWidget {
  const account_details_vehicle({Key? key}) : super(key: key);

  @override
  State<account_details_vehicle> createState() => _account_details_vehicleState();
}

class _account_details_vehicleState extends State<account_details_vehicle> {

  final _formKey = GlobalKey<FormState>();

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  final currentUser = FirebaseAuth.instance.currentUser;
  final  usersRef = FirebaseFirestore.instance.collection('users');

  TextEditingController displayVehicleNoController =TextEditingController();
 // TextEditingValue dropdownValue = TextEditingValue();
// TextEditingController dropdownValue = TextEditingController();
  String? dropdownValue;
  final dropdownValueKey = GlobalKey<FormState>();

  bool _displayVehicleNoValid = true;

  updateVehiclePlate() {
      usersRef.doc(user!.uid).update({
      "vehicle_license" : displayVehicleNoController.text
    });
    SnackBar snackbar = SnackBar(content: Text("Profile updated!"));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black26,
        content: Text('Profile updated '),
      ),
    );

  }

    updateVehicleType() {
      usersRef.doc(user!.uid).update({
      "vehicleType" : dropdownValue.toString()
    });
    SnackBar snackbar = SnackBar(content: Text("Profile updated!"));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black26,
        content: Text('Profile updated '),
      ),
    );

  }

  // Functions - Vehicle Type
  vehicle_type(BuildContext context) {

    String dropdownValue = '6 Ton';

    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        
        title: Text("Update Vehicle Type"),


           
        content:
        DropdownButton<String>(
          // Drop Down Menu Items
          items: <String>['Car','3 Ton', '3 Ton TG', '6 Ton', '6 Ton TG', '6 Ton OH','Van'].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          value: dropdownValue,

          icon: const Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.black),
          underline: Container(
            height: 2,
            color: Color(0xff2A4D69),
          ),
          onChanged: (String? value) {
            setState(() {
              dropdownValue = value!;
            });
          },


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
            onPressed:() {
              updateVehicleType();},//Navigator.of(context).pop(context);},
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

  // Vehicle Plate Number
  vehicle_plate(BuildContext context) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Update Vehicle Plate Number"),
        content: TextField(
          decoration: InputDecoration(
              hintText: "New Vehicle Plate Number"
          ),
          controller: displayVehicleNoController,
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
            onPressed: () {updateVehiclePlate();},
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

          // Vehicle Type
          Row(
              children:[
                Container(
                  padding: EdgeInsets.only(top: 30, left: 20,),
                  child: Text("VEHICLE TYPE",style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                //SizedBox(height: 50,),
                Container(
                  padding: EdgeInsets.only(top: 30, left: 30),
                  child: Text(" ${loggedInUser.vehicleType}"),
                ),
                Container(
                  padding: EdgeInsets.only(top: 30, left: 160),
                  child: IconButton(
                    onPressed: () {vehicle_type(context);},
                    icon: Icon(Icons.edit),
                  ),
                ),
              ]
          ),

          // Vehicle Number
          Row(
              children:[
                Container(
                  padding: EdgeInsets.only(top: 30, left: 20),
                  child: Text("VEHICLE NO",style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.only(top: 30, left: 20),
                  child: Text(" ${loggedInUser.vehicle_license}"),
                ),
                Container(
                  padding: EdgeInsets.only(top: 30, left: 150),
                  child: IconButton(
                    onPressed: () {vehicle_plate(context);},
                    icon: Icon(Icons.edit),
                  ),
                )
              ]
          ),
        ],
      ),
    );
  }
}
