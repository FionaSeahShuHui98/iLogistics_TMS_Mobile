import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:i_logistics/model/job_model.dart';
import 'package:i_logistics/repos/crud_iterface.dart';

class JobRepos extends CrudInterface {
  static const String collectionName = 'job';

  @override
  Future<void> add({required covariant Object data}) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<void> delete({required String id}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> update({required String id, required JobModel data}) async {
    try {
      DocumentSnapshot<Object?> result =
          await collection(collectionName).doc(data.job_id).get();
      if (result.exists) {
        data.setIsCompleted = true;
        await result.reference.set(data.toMap(), SetOptions(merge: true));
      }
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }
}
