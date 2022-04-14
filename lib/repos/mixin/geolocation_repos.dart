import 'package:i_logistics/repos/crud_iterface.dart';
import 'package:i_logistics/repos/mixin/geolocation_operations.dart';

class GeolocationRepos extends CrudInterface with GeolocationOperation {
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
  Future<void> update({required String id, required covariant Object data}) {
    // TODO: implement update
    throw UnimplementedError();
  }

}
