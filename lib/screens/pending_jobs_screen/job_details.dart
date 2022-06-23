import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_logistics/model/job.dart';
import 'package:i_logistics/screens/pending_jobs_screen/drop_off_screen.dart';
import 'package:i_logistics/screens/pending_jobs_screen/pickup_screen.dart';
import 'package:i_logistics/screens/pending_jobs_screen/signature_pad.dart';

import 'package:i_logistics/theme/color.dart';

import '../../theme/styles.dart';
import 'map_screen.dart';

class JobDetails extends StatefulWidget {
  final Job jobModel;
  const JobDetails({Key? key, required this.jobModel}) : super(key: key);

  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: detailsColor,
        title: const Text(
          'Jobs',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                  child: Text(
                widget.jobModel.deliverycontactname,
                style: Get.textTheme.headline6,
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.jobModel.pickupaddr1,
                style: Get.textTheme.headline6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.jobModel.deliveryaddr1,
                style: Get.textTheme.headline6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.jobModel.predPickuptime,
                style: Get.textTheme.headline6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.jobModel.predPickuptime,
                style: Get.textTheme.headline6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Center(
                child: TextButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MapScreen()),
                  ),
                  child: const Text(
                    'Recommended Route',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RawMaterialButton(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 16),
                    fillColor: proceedColor,
                    shape: buttonShape,
                    onPressed: ()
                      {Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => PickUpScreen()));},

                    child: const Text(
                      'Pick Up',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    )),
                RawMaterialButton(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 16),
                    fillColor: proceedColor,
                    shape: buttonShape,
                    onPressed: ()  {Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => DropOfScreen()));},
                    child: const Text(
                      'Drop Off',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
