// Importing Packages
import 'package:flutter/services.dart';
import 'package:i_logistics/repos/crud_iterface.dart';

// Importing Dart API
import 'dart:convert';

class InitDatabase extends CrudInterface {
  String? collectionName;
  set setCollection(val) {
    collectionName = val;
  }

  Future<List> readJson({required String filePath}) async {
    final String response = await rootBundle.loadString(filePath);
    final List data = await json.decode(response);


    return data;
  }

  Future<void> addFromFile(
      { required String filePath}) async {
    List data=await readJson(filePath: filePath);
    assert(collectionName!=null);
    for(var val in data){

      collection(collectionName!).add(val);
    }
  }

  @override
  Future<void> delete({required String id}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> update({required String id, required covariant Object data}) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<void> add({required covariant Object data}) {
    // TODO: implement add
    throw UnimplementedError();
  }
}
