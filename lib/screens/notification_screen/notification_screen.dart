import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_logistics/model/fcm_payload.dart';
import 'package:i_logistics/repos/push_notification_repos.dart';
import 'package:i_logistics/screens/pending_jobs_screen/drop_off_screen.dart';
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

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  SearchController searchController = Get.put(SearchController());
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





  Future<void> setup()async{
    InitDatabase initDatabase=InitDatabase();
    initDatabase.setCollection='job';
    await initDatabase.addFromFile(filePath: jobsData, );
    initDatabase.setCollection='user';
    await initDatabase.addFromFile(filePath: usersData, );
    initDatabase.setCollection='service_tier';
    await initDatabase.addFromFile(filePath: serviceTierData, );
    initDatabase.setCollection='hotline';
    await initDatabase.addFromFile(filePath: hotLineData, );
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
        await FirebaseFirestore.instance.collection('job').get();
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
        title: const Text("Notification"),
        centerTitle: true,
 
      ),
      body: SingleChildScrollView(
         child:  Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.blue,
                      child:           Row(
                     
                      children: [     
                          Checkbox(
                        value: false,
                        onChanged: (_) {
                    
                        }),
                        Text('Mark as Read')
                        ],
                    ),
                    ),
        
                    Row(
children: [Checkbox(
                        value: false,
                        
                        onChanged: (_) {
                    
                        }),
                            Icon(Icons.mail , size: 50,
                            
                            ),
                            
                            
                                 Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                               'Supervisor',
                                style: const TextStyle(fontSize: 22),
                              ),
                    
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Text(
                         "Staff Meeting this Monday",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                       
                      
                        ],
                      ),
                    ),
                                              
                       Icon(Icons.circle_rounded,color: Colors.red, ),
                            ],


          
                    ),
                      Row(
children: [Checkbox(
                        value: false,
                        
                        onChanged: (_) {
                    
                        }),
                            Icon(Icons.outgoing_mail , size: 50,
                            
                            ),
                            
                            
                                 Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                               'Team Leader',
                                style: const TextStyle(fontSize: 22),
                              ),
                    
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Text(
                         "Team Meeting this Monday",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                       
                      
                        ],
                      ),
                    ),
                  
                            ],


          
                    ),
                    
               

                  ],
                ),
              ),
 
      ),
     
    );
  }
}

enum SearchBy { collection, delivery }
