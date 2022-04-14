import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';
import 'change_password.dart';
import '../login_screen.dart';
import '../notification_screen/notification_screen.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  final currentUser = FirebaseAuth.instance.currentUser;
  final usersRef = FirebaseFirestore.instance.collection('users');

  TextEditingController displayVehicleTypeController = TextEditingController();
  TextEditingController displayVehicleNoController = TextEditingController();

  bool _displayVehicleTypevalid = true;
  bool _displayVehicleNoValid = true;

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

  updateProfileData() {
    usersRef.doc(loggedInUser.userid).update({
      "vehicleType": displayVehicleTypeController.text,
      "vehicleNo": displayVehicleNoController.text
    });
    SnackBar snackbar = const SnackBar(content: const Text("Profile updated!"));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.black26,
        content: const Text('Profile updated '),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2a4d69),
        title: Text("Completed Jobs"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext)=>const NotificationScreen()));},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipOval(
                child: Image.asset(
                  "assets/logo.png",
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                " ${loggedInUser.name} ",
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              // Text("${loggedInUser.firstName} ${loggedInUser.secondName}",
              //     style: TextStyle(
              //       color: Colors.black54,
              //       fontWeight: FontWeight.w500,
              //     )),
              Text("${loggedInUser.email}",
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 15,
              ),
              //vehicles

              TextFormField(
                autofocus: false,
                decoration: const InputDecoration(
                  labelText: "Vehicle Type:",
                  hintText: "Vehicle Type",
                ),
                controller: displayVehicleTypeController,
              ),
              TextFormField(
                autofocus: false,
                decoration: const InputDecoration(
                  labelText: "Vehicle No:",
                  hintText: "Vehicle No",
                  // helperText: "${loggedInUser.vehicleNo}"
                ),
                controller: displayVehicleNoController,
              ),
              RaisedButton(
                onPressed: updateProfileData,
                child: Text(
                  "Update Profile",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                child: const Text('Change Password'),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => ChangePasswordScreen()),
                ),
              ),
              ActionChip(
                  label: const Text("Logout"),
                  onPressed: () {
                    logout(context);
                  }),
            ],
          ),
        ),
      ),
    ),);
  }
  // Logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
