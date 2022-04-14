import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../model/fcm_payload.dart';

abstract class FcmInterface {
  final String serverToken =
      'AAAAo47AwU4:APA91bFY0Hy-KJUz6P205wsByNI4CRQWH0AprEOjlLy8kCShyVuLNqXAD5OY624tTCOh_yQx4cS_MTpfnc8YrS4hsigpg3G--uIF_PzqSu37qF4lhVolIIC4NUx94gtuIqN1WDI4Ephl';
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<String?> myFcmToken();
  Future<void> sendNotification(
      {required String userFcmToken, required FcmPayLoad fcmPayLoad});
  void onMessage();

  Widget get popUpContent;
}
