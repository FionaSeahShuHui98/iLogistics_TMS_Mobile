import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_logistics/model/job.dart';
import 'package:i_logistics/model/job_model.dart';
import 'package:i_logistics/screens/pending_jobs_screen/job_details.dart';
import 'package:i_logistics/screens/pending_jobs_screen/map_screen.dart';

import '../controller/search_controller.dart';
import '../screens/reset_screen.dart';
import '../theme/color.dart';
import '../theme/styles.dart';

class JobItem extends GetView<SearchController> {
  final Job jobModel;
  const JobItem({Key? key, required this.jobModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                    activeColor: Color(0xff2A4D69),
                        value: controller.jobsChecked
                            .contains(jobModel.id.toString()),
                        onChanged: (_) {
                          if (controller.jobsChecked.contains(jobModel.id.toString())) {
                            controller.jobsChecked.remove(jobModel.id.toString());
                          } else {
                            controller.jobsChecked.add(jobModel.id.toString());
                          }
                          controller.update();
                        }),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                jobModel.deliverycontactname.toString(),
                                style: const TextStyle(fontSize: 22),
                              ),
                              RawMaterialButton(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 12),
                                  fillColor: jobModel.jobType.toString().toLowerCase() == 'collection'
                                      ? collectionColor
                                      : deliveryColor,
                                  shape: buttonShape,
                                  onPressed: () {},
                                  child: Text(
                                    jobModel.jobType.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Text(
                              jobModel.pickupaddr1 ?? "",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          Text(jobModel.deliveryaddr1 ?? "",
                              style: const TextStyle(fontSize: 16))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
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
                    RawMaterialButton(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 19, vertical: 16),
                        fillColor: detailsColor,
                        shape: buttonShape,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                       JobDetails(jobModel: jobModel,)));
                        },
                        child: const Text(
                          'View Details',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.white),
                        ))
                  ],
                ),
              ),
              const Divider(
                color: Colors.black,
                indent: 3,
              )
            ],
          ),
        ));
  }
}
