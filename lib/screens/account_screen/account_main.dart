// Importing Packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:i_logistics/screens/account_screen/account_details.dart';
import 'package:i_logistics/screens/account_screen/change_password.dart';
import 'package:i_logistics/screens/account_screen/settings.dart';
import 'package:i_logistics/screens/login_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
// import 'package:html/html.dart' as h;

// Importing Dart API
import 'dart:async';
import 'dart:io';
import 'dart:io' as i;

// Importing Models
import '../../model/user_model.dart';

// Importing Other Screen
import '../notification_screen/notification_screen.dart';

class account_screen extends StatefulWidget {
  const account_screen({Key? key}) : super(key: key);
  @override
  _account_screenState createState() => _account_screenState();
}

class _account_screenState extends State<account_screen> {
  // Declaration
  late PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _load = false;

  // Google Firebase Set-Up
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

  @override
  Widget build(BuildContext context) {
    
    // Uploading of Picture to Database
    Future uploadPic(BuildContext context) async{
      String fileName = basename(_imageFile.path);
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("image" + DateTime.now().toString());
      UploadTask uploadTask = ref.putFile(File(_imageFile.path));
      setState(() {
          print("Profile Picture uploaded");
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
      });
      uploadTask.then((res) {
        res.ref.getDownloadURL();
      });
    };

    // Function to allow user to choose photo from either Gallery / Camera
    void takePhoto(ImageSource source) async {
      final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile!;
      _load = true;
    });
    uploadPic(context);
  }

     return Scaffold(

       // Header
       appBar: AppBar(
         title: Text('Account'),
         centerTitle: true,
         actions: [
           IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const NotificationScreen()));},
               icon: const Icon(Icons.notifications))
         ],
       ),
       
       // Main Content
       body: Builder(
          builder: (context) =>  Container(
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
              SizedBox(height: 50),
              // Profile Picture
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: [
                        // Profile Picutre
                        Align(
                  alignment: Alignment.center,
                  child:  CircleAvatar(
                    radius: 80.0,
                    backgroundImage: _load==true?
                    FileImage(File(_imageFile.path)) :
                    AssetImage("assets/logo.png")as ImageProvider,
                  ),
                ),
                        // Edit Profile Picture - Camera
                        Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color: Color(0xff2A4D69),
                                ),
                                color: Color(0xff2A4D69),
                              ),
                              child: IconButton(
                                onPressed: () {takePhoto(ImageSource.camera);},
                                icon: Icon(Icons.camera_alt),
                                color: Colors.white,
                              ),
                            )
                        ),
                        // Edit Profile Picture - Gallery
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color: Color(0xff2A4D69),
                                ),
                                color: Color(0xff2A4D69),
                              ),
                              child: IconButton(
                                onPressed: () {takePhoto(ImageSource.gallery);},
                                icon: Icon(Icons.edit),
                                color: Colors.white,
                              ),
                            )
                        ),
                      ]
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Username, Position, Menu
              Column(
                children: [
                  // User Name
                  Text(
                    " ${loggedInUser.name}",
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  // Role / Positioned in the Company
                  Text(
                    " ${loggedInUser.role}",
                    style: const TextStyle(
                        fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  // View Profile
                  ListTile(
                    leading: new Icon(Icons.account_circle, size: 35,),
                    title: new Text('Personal Particulars', style: TextStyle(fontSize: 18,),),
                    onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => account_details(),));},
                  ),
                  // Change Password
                  ListTile(
                    leading: new Icon(Icons.lock,  size: 35,),
                    title: new Text('Change Password', style: TextStyle(fontSize: 18),),
                    onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangePasswordScreen(),));},
                ),
                  // Settings
                  ListTile(
                    leading: new Icon(Icons.settings,  size: 35,),
                    title: new Text('Settings', style: TextStyle(fontSize: 18),),
                    onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => settings_screen(),));},
                  )
              ],
            ),
              // Logout Button
              Material(
                child: Container(
                  width: double.infinity,
                  height: 40,
                  margin: EdgeInsets.only(top: 30, left: 20, right: 20,),
                  child: ElevatedButton.icon(
                    onPressed: () {logout(context);},//Navigator.of(context).push(MaterialPageRoute(builder: (context) => login_screen(),));},
                    icon: Icon(Icons.logout),
                    label: Text(
                      "Logout",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffDC3545),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )
                    ),
                  ),
                ),
              ),
              //SizedBox(height: 0),
            ],
          ),
        ),
       ),
     );
  }

  // Logout Button Function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
