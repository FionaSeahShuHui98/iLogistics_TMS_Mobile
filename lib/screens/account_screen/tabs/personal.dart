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
   TextEditingController changeDobController = TextEditingController();
    TextEditingController changeNameController = TextEditingController();
     TextEditingController changeEmailController = TextEditingController();
      TextEditingController changeAddressController = TextEditingController();

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

    updatePhoneData() {
    usersRef.doc(user!.uid).update({
      "phone": changePhoneNumberController.text,

    });
     
    SnackBar snackbar = const SnackBar(content: const Text("Profile updated!"));
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        backgroundColor: Colors.black26,
        content: const Text('Profile updated '),
      ),
    );
  }

    updateDobData() {
    usersRef.doc(user!.uid).update({

      "dob":changeDobController.text,
 
    });
     
    SnackBar snackbar = const SnackBar(content: const Text("Profile updated!"));
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        backgroundColor: Colors.black26,
        content: const Text('Profile updated '),
      ),
    );
  }

    updateNameData() {
    usersRef.doc(user!.uid).update({

      "name":changeNameController.text,
    // "vehicleNo": displayVehicleNoController.text
    });
     
    SnackBar snackbar = const SnackBar(content: const Text("Profile updated!"));
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        backgroundColor: Colors.black26,
        content: const Text('Profile updated '),
      ),
    );
  }

  updateEmailData() {
    usersRef.doc(user!.uid).update({

      "email":changeEmailController.text,

    });
     
    SnackBar snackbar = const SnackBar(content: const Text("Profile updated!"));
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        backgroundColor: Colors.black26,
        content: const Text('Profile updated '),
      ),
    );
  }

    updateAddressData() {
    usersRef.doc(user!.uid).update({
      "address":changeAddressController.text     // "vehicleNo": displayVehicleNoController.text
    });
     
    SnackBar snackbar = const SnackBar(content: const Text("Profile updated!"));
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        backgroundColor: Colors.black26,
        content: const Text('Profile updated '),
      ),
    );
  }





  Widget build(BuildContext context) {


  handphone_number(BuildContext context) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Update  Number"),
        content: TextField(
          decoration: InputDecoration(
              hintText: "New Number"
          ),
          controller: changePhoneNumberController,
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
            onPressed: () {updatePhoneData();},
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


  name(BuildContext context) {
      return showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text("Update Name"),
          content: TextField(
            decoration: InputDecoration(
                hintText: "New Name"
            ),
            controller: changeNameController,
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
              onPressed: () {updateNameData();},
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

      dob(BuildContext context) {
      return showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text("Update Date of Birth"),
          content: TextField(
            decoration: InputDecoration(
                hintText: "New Date of Birth"
            ),
            controller: changeDobController,
            keyboardType: TextInputType.phone,
          ),
          actions: [
            ElevatedButton.icon(
              onPressed: () {   Navigator.of(context).pop(context);},
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
              onPressed: () { updateDobData();
             },
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
            controller: changeEmailController,
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
              onPressed: () {updateEmailData();},
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
            controller: changeAddressController,
            //keyboardType: TextInputType.phone,
          ),
          actions: [
            ElevatedButton.icon(
              onPressed: () {   Navigator.of(context).pop(context);},
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
              onPressed: () {updateAddressData();},
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
                child: Text(" ${loggedInUser.name}"),
              ),
                    Container(
                padding: EdgeInsets.only(top: 40, left: 160),

              )
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
                     Container(
                padding: EdgeInsets.only(top: 40, left: 90),

              )
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
                padding: EdgeInsets.only(top: 40, left: 100),
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
                    Container(
                padding: EdgeInsets.only(top: 40, left: 100),
                child: IconButton(
                  onPressed: () {
                   address(context);
                  },
                  icon: Icon(Icons.edit),
                ),
              )
            ]
        ),

      ],
    );
  }
}
