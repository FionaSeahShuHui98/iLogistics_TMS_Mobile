// Import Packages
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JobModel {
  // Declaration
  static const String _isCompleted = 'is_completed';
  bool isCompleted;
  final String job_id;
  final String? cust_name;
  final String? job_type;
  final String? collection_address;
  final String? delivery_address;

  set setIsCompleted(val) {
    isCompleted = val;
  }

  JobModel(
      {required this.job_id,
      this.job_type,
      this.cust_name,
      this.collection_address,
      this.delivery_address,
      this.isCompleted = false});

  // Receive data from server
  factory JobModel.fromMap(map) {
    return JobModel(
      job_id: map['job_id'],
      cust_name: map['cust_name'],
      job_type: map['job_type'],
      collection_address: map['collection_address'],
      delivery_address: map['delivery_address'],
      isCompleted: map[_isCompleted],
    );
  }

  // Send Data from Server
  Map<String, dynamic> toMap() {
    return {
      'job_id': job_id,
      'cust_name': cust_name,
      'job_type': job_type,
      'collection_address': collection_address,
      'delivery_address': delivery_address,
      _isCompleted: isCompleted
    };
  }

  JobModel.fromSnapshot(DocumentSnapshot snapshot)
      : isCompleted = snapshot[_isCompleted],
        job_id = snapshot['job_id'],
        cust_name = snapshot['cust_name'],
        job_type = snapshot['job_type'],
        collection_address = snapshot['collection_address'],
        delivery_address = snapshot['delivery_address'];
}
