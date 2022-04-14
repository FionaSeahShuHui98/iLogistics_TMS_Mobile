import 'package:flutter/material.dart';
import 'package:i_logistics/model/extensions/date_format.dart';
import 'package:i_logistics/theme/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';

import 'package:i_logistics/theme/assets.dart';
import 'package:i_logistics/widget/completed_job_item.dart';

import '../../controller/search_controller.dart';
import '../../model/job.dart';

import '../../model/user_model.dart';
import '../../theme/color.dart';
import '../../theme/styles.dart';
import '../notification_screen/notification_screen.dart';


class CompletedJobScreen extends StatefulWidget {
  const CompletedJobScreen({Key? key}) : super(key: key);

  @override
  _CompletedJobScreenState createState() => _CompletedJobScreenState();
}

class _CompletedJobScreenState extends State<CompletedJobScreen> {
  SearchController searchController = Get.put(SearchController());
  SearchBy? _searchBy;
  final TextEditingController _searchController = TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  final CollectionReference jobReference =
  FirebaseFirestore.instance.collection('jobs');

  final currentUser = FirebaseAuth.instance.currentUser;
  final usersRef = FirebaseFirestore.instance.collection('users');

  late Future resultsLoaded;
  List<Job> jobsListMap = [];

  Set<String> jobsChecked = {};

  bool searchLogic({required Job job}) =>
      (_searchBy != null
          ? (job.id == SearchBy.values[_searchBy!.index].name)
          : true) &&
          (job.deliverycontactname!
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()));



  @override
  void initState() {


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

    List<Job>  list = result.docs.map((e) => Job.fromJson(e.data())).toList();
    list=list.where((element) => searchController.jobsChecked.value.contains(element.id.toString())).toList();

    final Set<String?> allJobsId = list.map((e) => e.id.toString()).toSet();
    searchController.allCompletedJobs.value = allJobsId;


    return list;
  }

  void reRender() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2a4d69),
        title: Text("Completed Jobs"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext)=>const NotificationScreen()));},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 18,bottom: 22,left: 10,right: 10),
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
            Container(color: dateColor,
            child: Row(mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(DateTime.now().format2(),style: const TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.w700),),
              )
            ],),),

            Row(mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(DateTime.now().format1(),style: const TextStyle(fontSize: 19,fontWeight: FontWeight.w700),),
                )
              ],),
            const Divider(thickness: 2,color: Colors.black,),

            FutureBuilder<List<Job>>(
              future: fetchDatabaseList(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Job>> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: snapshot.data!
                        .map((e) => searchLogic(job: e)
                        ? CompletedJobItem(
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

    );
  }
}

enum SearchBy { collection, delivery }
