// Import Package
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
   RxSet<String?>  jobsChecked=<String>{}.obs;
   RxSet<String?>  allJobs=<String>{}.obs;
   RxSet<String?>  allCompletedJobs=<String>{}.obs;
   RxSet<String?> tempJobId=<String>{}.obs;
  Rx<TextEditingController> textEditingController = (TextEditingController()).obs;
}
