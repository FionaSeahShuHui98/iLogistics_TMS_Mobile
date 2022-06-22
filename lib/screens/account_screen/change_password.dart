import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:i_logistics/screens/login_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // Decalration
  var password_lock = false;
  var password_lock_1=false;
  bool checkCurrentPasswordValid = true;
  var newPassword=" ";

  // Text Controller
  var _passwordController = TextEditingController();
  final newPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  final currentUser = FirebaseAuth.instance.currentUser;

  changePassword() async{
    try{
      await currentUser!.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),
      ),
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.black26,
        content: Text('Your password has been changed... Login again ! '),
      ),

      );
    } catch(error){

    }
  }

  checkPassword(String password) async{
    var authCredentials = EmailAuthProvider.credential(
        email: currentUser!.email!, password: password);
    try{
      var authResult = await currentUser!.reauthenticateWithCredential(authCredentials);
      return authResult.user!=null;
    } catch(error){
      print(error);
      return false;
    }
  }

  late String _email;
  final TextEditingController emailController = new TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff2A4D69),
          title: Text("Change Password"),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              // passing this to our root
              Navigator.of(context).pop();
            },
          ),
        ),

        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
            child: ListView(
              children: [

                SizedBox(height: 50,),

                // Title
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 30, right: 20, left: 60,),

                  child: Text(
                    "Change Password", style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2A4D69),
                    ),
                  ),
                ),

                SizedBox(height: 50,),

                // Old Password
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: Center(
                    child: TextFormField(
                      autofocus: false,
                      obscureText: password_lock ? false : true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              password_lock = !password_lock;
                            });
                          },
                          icon: Icon(
                            password_lock
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        ),
                        border: OutlineInputBorder(),
                        labelText: "Old Password",
                        hintText: 'Enter Old Password',
                        errorText: checkCurrentPasswordValid
                            ? null
                            : "Please double check your current password",
                      ),
                      controller: _passwordController,
                    ),
                  ),
                ),

                // New Password
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(autofocus: false,
                 obscureText: password_lock_1 ? false : true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              password_lock_1 = !password_lock_1;
                            });
                          },
                          icon: Icon(
                            password_lock_1
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        ),
                      labelText: 'New Password',
                      hintText: 'Enter New password',
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(color: Colors.black),
                    ),
                    controller: newPasswordController,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Please enter password';
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 30,),

                // Change Password Button
                Container(
                  width: double.infinity,
                  height: 50,
                  margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.lock_clock),
                    label: Text(
                      "Change Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xff2A4D69),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                    ),
                    onPressed: () async{
                      checkCurrentPasswordValid = await checkPassword(_passwordController.text);
                      setState(() {});
                      if(_formKey.currentState!.validate() && checkCurrentPasswordValid){
                        setState(() {
                          newPassword = newPasswordController.text;
                        },
                        );
                        changePassword();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        )

    );
  }

}