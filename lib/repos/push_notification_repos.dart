import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_logistics/controller/search_controller.dart';
import 'package:i_logistics/model/fcm_payload.dart';
import 'package:i_logistics/model/job.dart';
import 'package:i_logistics/screens/pending_jobs_screen/job_details.dart';

import '../theme/assets.dart';
import '../theme/color.dart';
import '../theme/styles.dart';
import 'fcm_interface.dart';
import 'package:http/http.dart' as http;

class PushNotificationRepos extends FcmInterface {
  @override
  Future<String?> myFcmToken() async {
    try {
      String? token = await messaging.getToken();
      return token;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> sendNotification(
      {required String userFcmToken, required FcmPayLoad fcmPayLoad}) async {
    try {
      await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverToken',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': fcmPayLoad.toMap,
            'priority': 'high',
            "android": <String, dynamic>{
              "notification": <String, dynamic>{"channel_id": 'Channel ID'}
            },
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            },
            'to': userFcmToken,
          },
        ),
      );
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void onMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Get.defaultDialog(title: '', content: popUpContent);

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  @override
  Widget get popUpContent => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Image.asset(note),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              'New Job Assigned',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text('Pick Up Location: DHL Supply Chain Advanced Regional Centre'),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text('Drop Off Location: 662B EDGEDALE PLAINS, WATERWAY SUNDEW'),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RawMaterialButton(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 19, vertical: 16),
                  fillColor: detailsColor,
                  shape: buttonShape,
                  onPressed: () {
                    //todo uncomment the next lines and update the values :)
                    SearchController searchController = Get.find();
                    Get.to(JobDetails(jobModel: Job(jobno: 22010008,
                     subcustomerid: 72 ,
                      customerid: 70, 
                      driverid: 69,
                       pickupaddr1: "DHL Supply Chain Advanced Regional Centre", 
                       pickupaddr2: "1 Greenwich Dr", 
                       pickupaddrpostal: 
"533865", 
                       altref: 123471, 
                       deliveryaddr1: "662B EDGEDALE PLAINS, WATERWAY SUNDEW",
                        deliveryaddr2: "#01-123",
                         deliveryaddrpostal: 822662,
                          weight: 1,
                           activationdate: 
"2022-01-11T10:08:37.013",
                            predEta: "2019-05-09T09:00:00", 
                            remarks: "", 
                            jobType: "Collection", 
                            quantity: 1,
                             status: "Assigned",
                              predPickuptime: "2019-05-09T10:00:00", 
                              serviceid: 6, 
                              jobCategory: "Adhoc",
                               pickupcontactname: "John Wayne",
                                pickupcontactno: "92692976", 
                                deliverycontactname: 
"Chris",
                                 deliverycontactno: "93082987", 
                                 ItemDesc: "Loki and Sylvie", DoNo: 1, id: 138)));
                  },
                  child: const Text(
                    'View Details',
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.white),
                  )),
              RawMaterialButton(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                  fillColor: cancelColor,
                  shape: buttonShape,
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.white),
                  ))
            ],
          )
        ],
      );
}
