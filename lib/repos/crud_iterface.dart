import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CrudInterface{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collection(String collection) => FirebaseFirestore.instance.collection(collection);
  Future<void> add({required covariant Object data});
  Future<void> delete({required String id});
  Future<void> update({required String id,required covariant  Object data});
}