import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_logistics/model/fcm_payload.dart';
import 'package:i_logistics/repos/push_notification_repos.dart';
import 'package:i_logistics/screens/pending_jobs_screen/drop_off_screen.dart';
import 'package:i_logistics/screens/notification_screen/notification_screen.dart';
import 'package:i_logistics/screens/pending_jobs_screen/pickup_screen.dart';
import 'package:i_logistics/theme/assets.dart';

import '../../controller/search_controller.dart';
import '../../init_database/init_database.dart';
import '../../model/job.dart';
import '../../model/job_model.dart';
import '../../model/user_model.dart';
import '../../theme/color.dart';
import '../../theme/styles.dart';
import '../../widget/job_item.dart';

class JobScreen extends StatefulWidget {
  const JobScreen({Key? key}) : super(key: key);

  @override
  _JobScreenState createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  TransferableTypedData data=TransferableTypedData.fromList([]);

  SearchController searchController = Get.find();
  SearchBy? _searchBy;
  final TextEditingController _searchController = TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  final CollectionReference jobReference =
  FirebaseFirestore.instance.collection('job');

  final currentUser = FirebaseAuth.instance.currentUser;
  final usersRef = FirebaseFirestore.instance.collection('users');

  late Future resultsLoaded;
  List<JobModel> jobsListMap = [];

  Set<String> jobsChecked = {};

  bool searchLogic({required Job job}) =>
      (_searchBy != null
          ? (job.jobType.toString().toLowerCase() == SearchBy.values[_searchBy!.index].name.toLowerCase() ): true) &&
          (job.deliverycontactname
              .toLowerCase()
              .contains(_searchController.text.toLowerCase())||job.deliveryaddr1
              .toLowerCase()
              .contains(_searchController.text.toLowerCase())
              ||job.pickupaddr1
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase())
          );

  @override
  void initState() {
    data.materialize();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = fetchDatabaseList();
  }

  Future<List<Job>> fetchDatabaseList() async {
    QuerySnapshot<Map<String, dynamic>> result =
    await FirebaseFirestore.instance.collection('jobs').get();
    final list = result.docs.map((e) => Job.fromJson(e.data())).toList();
    final Set<String?> allJobsId = list.map((e) => e.id.toString()).toSet();
    searchController.allJobs.value = allJobsId;

    return list;
  }

  void reRender() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {    Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext
                  context) =>
                  const NotificationScreen()));}, icon: const Icon(Icons.notifications))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (_) {
                          setState(() {});
                        },

                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                            prefixIcon: Icon(Icons.search),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                            ),
                            hintText: 'Search',
                            border: InputBorder.none),
                        // onChanged: onSearchTextChanged,
                      ),
                    ),
                    IconButton(
                      icon: Image.asset(filter),
                      onPressed: () {
                        Get.defaultDialog(
                            title: '',
                            content: StatefulBuilder(
                              builder: (BuildContext context,
                                  void Function(void Function()) setState) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    DropdownButton<SearchBy>(
                                      items: SearchBy.values
                                          .map(
                                              (e) => DropdownMenuItem<SearchBy>(
                                            child: Text(e.name),
                                            value: e,
                                          ))
                                          .toList(),
                                      onChanged: (val) {
                                        debugPrint(val.toString());
                                        setState(() {
                                          _searchBy = val;
                                        });
                                      },
                                      value: _searchBy,
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(bottom: 12),
                                      child: RawMaterialButton(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25, vertical: 19),
                                          fillColor: detailsColor,
                                          shape: buttonShape,
                                          onPressed: () {
                                            Get.back();

                                            reRender();
                                          },
                                          child: Row(
                                            children: const [
                                              Text(
                                                'Confirm',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 19,
                                                    color: Colors.white),
                                              ),
                                            ],
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                          )),
                                    ),
                                    RawMaterialButton(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 19),
                                        fillColor: cancelColor,
                                        shape: buttonShape,
                                        onPressed: () {
                                          Get.back();
                                          _searchBy = null;

                                          reRender();
                                        },
                                        child: Row(
                                          children: const [
                                            Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 19,
                                                  color: Colors.white),
                                            ),
                                          ],
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                        )),
                                  ],
                                );
                              },
                            ));
                      },
                    ),
                  ],
                )),
            Obx(() => Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                    activeColor: Color(0xff2A4D69),
                    value: setEquals(searchController.allJobs,
                        searchController.jobsChecked),
                    onChanged: (_) {
                      print(searchController.allJobs.length);
                      if (setEquals(searchController.allJobs,
                          searchController.jobsChecked)) {
                        debugPrint('1');
                        searchController.jobsChecked.clear();

                      } else {
                        debugPrint('2');
                        searchController.jobsChecked
                            .addAll(searchController.allJobs);
                      }
                    }),
                Text(
                  setEquals(searchController.allJobs,
                      searchController.jobsChecked)
                      ? 'Deselect All'
                      : 'Select All',
                  style: const TextStyle(fontSize: 17),
                ),
              ],
            )),
            FutureBuilder<List<Job>>(
              future: fetchDatabaseList(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Job>> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: snapshot.data!
                        .map((e) => searchLogic(job: e)
                        ? JobItem(
                      jobModel: e,
                    )
                        : const SizedBox())
                        .toList(),
                  );
                }
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }

                return Text(snapshot.connectionState.toString());
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => searchController.jobsChecked.isEmpty
          ? const SizedBox()
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(
              color: Color(0xff2A4D69),
              thickness: 2,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${searchController.jobsChecked.length} Jobs Selected",
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.w500),
                ),
                RawMaterialButton(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 16),
                    fillColor: detailsColor,
                    shape: buttonShape,
                    onPressed: () {
                      Get.defaultDialog(
                          title: '',
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(bottom: 30),
                                child: RawMaterialButton(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 16),
                                    fillColor: proceedColor,
                                    shape: buttonShape,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext
                                              context) =>
                                              const PickUpScreen()));
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Pickup',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      ],
                                    )),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(bottom: 50),
                                child: RawMaterialButton(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 16),
                                    fillColor: proceedColor,
                                    shape: buttonShape,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext
                                              context) =>
                                              const DropOfScreen()));
                                    },
                                    child: Row(
                                      children: const [
                                        Text(
                                          'Drop Off',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      ],
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                    )),
                              ),
                              RawMaterialButton(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 16),
                                  fillColor: cancelColor,
                                  shape: buttonShape,
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Row(
                                    children: const [
                                      Text(
                                        'Cancel',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ],
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                  ))
                            ],
                          ));
                    },
                    child: const Text(
                      'Proceed',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ))
              ],
            ),
          ],
        ),
      )),
    );
  }
}

enum SearchBy { collection, delivery }
