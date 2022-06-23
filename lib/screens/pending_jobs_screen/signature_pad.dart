// ignore_for_file: dead_code

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:i_logistics/screens/pending_jobs_screen/pickup_screen.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui ;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:convert';

import '../../theme/color.dart';
import '../../theme/styles.dart';

// string for displaying the error Message
String? errorMessage;

class SignatureScreen extends StatefulWidget {
  @override
  _SignatureScreenState createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  // form key
  final _formKey = GlobalKey<FormState>();
  GlobalKey<SfSignaturePadState> _signaturePadStateKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: const Text('Signature'),
              backgroundColor: detailsColor,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
      body: Center(
          child: Container(
        child:  Column(
          children: [
            SfSignaturePad(
              key: _signaturePadStateKey,
              backgroundColor: Colors.grey,
              strokeColor: Colors.white,
              minimumStrokeWidth: 4.0,
              maximumStrokeWidth: 6.0,
              ),

          ]
        ),

        height: 300,
        width: 300,
        ),

       
      ),
            bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RawMaterialButton(
              padding:
              const EdgeInsets.symmetric(horizontal: 70, vertical: 16),
              fillColor: detailsColor,
              shape: buttonShape,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const PickUpScreen();
                }));
              },
              child: const Text(
                'Submit',
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.white),
              )),
          RawMaterialButton(
              padding:
              const EdgeInsets.symmetric(horizontal: 70, vertical: 16),
              fillColor: cancelColor,
              shape: buttonShape,
              onPressed: () {},
              child: const Text(
                'Cancel',
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.white),
              ))
        ],
      ),
    ),
        ),
    );
  }
}

// }