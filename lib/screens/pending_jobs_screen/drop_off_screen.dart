import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_logistics/screens/pending_jobs_screen/signature_pad.dart';

import '../../theme/color.dart';
import '../../theme/styles.dart';
import '../../widget/pickup_item.dart';
import '../completed_jobs_screen/completed_job_screen.dart';
import '../reset_screen.dart';

class DropOfScreen extends StatefulWidget {
  const DropOfScreen({Key? key}) : super(key: key);

  @override
  _PickUpScreenState createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<DropOfScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Proof of Delivery'),
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                  child: Text(
                'Drop Off',
                style: Get.textTheme.headline6,
              )),
            ),
            const Divider(thickness: 1,color: Colors.black,),
            PickupItem(
              title: 'Signature',
              buttonFunction: () {Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => SignatureScreen()));},
              buttonTitle: 'Upload',
            ),
            PickupItem(
              title: 'QR Code',
              buttonFunction: () {},
              buttonTitle: 'Scan',
            ),
            PickupItem(
              title: 'Bar Code',
              buttonFunction: () {},
              buttonTitle: 'Scan',
            ),
            PickupItem(
              title: 'Location Photo',
              buttonFunction: () {},
              buttonTitle: 'Upload',
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RawMaterialButton(
                padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 16),
                fillColor: detailsColor,
                shape: buttonShape,
                onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const CompletedJobScreen();
                }));},
                child: const Text(
                  'Submit',
                  style:
                      TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
                )),
            RawMaterialButton(
                padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 16),
                fillColor: cancelColor,
                shape: buttonShape,
                onPressed: () {},
                child: const Text(
                  'Cancel',
                  style:
                      TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
