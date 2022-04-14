import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_logistics/model/job_model.dart';

import '../model/job.dart';
import '../theme/color.dart';
import '../theme/styles.dart';

class CompletedJobItem extends StatelessWidget {
  final Job jobModel;
  const CompletedJobItem({Key? key, required this.jobModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      jobModel.deliverycontactname!,
                      style: Get.textTheme.headline6,
                    ),
                    RawMaterialButton(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 12),
                        fillColor: jobModel.jobType == 'collection'
                            ? collectionColor
                            : deliveryColor,
                        shape: buttonShape,
                        onPressed: () {},
                        child: Text(
                          jobModel.jobType!,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(jobModel.deliveryaddr1!,
                    style: const TextStyle(fontSize: 19)),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(jobModel.pickupaddr1!,
                    style: const TextStyle(fontSize: 19)),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 2,
          color: Colors.black,
        )
      ],
    );
  }
}
