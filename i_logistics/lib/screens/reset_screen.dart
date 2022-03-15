import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
    // form key
  final _formKey = GlobalKey<FormState>();
  late String _email;
   final TextEditingController emailController = new TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
     //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )
        );

        //reset button
        final resetButton = 
                       Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xff2a4d69),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
            onPressed: () {
                  auth.sendPasswordResetEmail(email: emailController.text)
                       .then((uid) => {
                  Fluttertoast.showToast(msg: "Request Sent"),
             
                });;
                  
                  Navigator.of(context).pop();
                },
          child: Text(
            "Send Request",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(  
          backgroundColor: Color(0xfffafafa),
                appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xff2a4d69)),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Color(0xfffafafa),
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
             
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
                "Reset Password",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xff2a4d69)),
              ),
                    SizedBox(height: 45),
                    emailField,
                 
                    SizedBox(height: 35),
                   resetButton,
                    SizedBox(height: 15),
                        
                  
              
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
 
    );
  }

}