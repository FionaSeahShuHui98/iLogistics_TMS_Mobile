// ignore_for_file: dead_code

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui ;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:convert';

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
              ElevatedButton(onPressed: () async{
                ui.Image image =
                await _signaturePadStateKey.currentState!.toImage(
                  pixelRatio: 2.0
                );

              final ByteData = 
              await image.toByteData(format: ui.ImageByteFormat.png);

              final Uint8List imageBytes = ByteData!.buffer.asUint8List(
                ByteData.offsetInBytes, ByteData.lengthInBytes
              );

              if (kIsWeb){
                AnchorElement(href: 'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(imageBytes)}')
                ..setAttribute('download', 'Output.png')
                ..click();
              }
              final String path =  (await getApplicationDocumentsDirectory()).path;
              final String fileName = Platform.isWindows? '$path\\Output.png': '$path/Output.png';
              final File file = File(fileName);
              await file.writeAsBytes(imageBytes,flush: true);
              OpenFile.open(fileName);

              }, child: Text('Save as Image'))]),
               
        height: 300,
        width: 300,
        ),
       
      )),
    );
  }
}

// }