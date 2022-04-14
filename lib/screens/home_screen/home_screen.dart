import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:i_logistics/screens/account_screen/account_details.dart';
import 'package:i_logistics/screens/account_screen/account_main.dart';
import 'package:i_logistics/screens/call_screen/call_main.dart';
import 'package:i_logistics/screens/completed_jobs_screen/completed_job_screen.dart';
import 'package:i_logistics/screens/pending_jobs_screen/job_screen.dart';
import 'package:i_logistics/screens/account_screen/update_profile.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../../controller/search_controller.dart';
import '../../init_database/init_database.dart';
import '../../model/fcm_payload.dart';
import '../../model/user_model.dart';
import '../../repos/push_notification_repos.dart';
import '../../theme/assets.dart';
import '../login_screen.dart';
import '../notification_screen/notification_screen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();

}


class _HomeScreenState extends State<HomeScreen> {
  SearchController searchController = Get.put(SearchController());
  final List<Widget> pages = [

    // Padding(
    //   padding: const EdgeInsets.all(8.0),
    Center(

      child: Container(
        margin: EdgeInsets.only(bottom: 50),
        // child:Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        child:
        // Expanded(
        //     child: SizedBox(
        //   height: 100,
        // )),
        Stack(
          children: <Widget> [
            SfCircularChart(
                legend: Legend(isVisible: true,
                    position: LegendPosition.bottom,
                    orientation:LegendItemOrientation.vertical ),
                margin: EdgeInsets.all(5),



                series: <CircularSeries>[
                  // Renders doughnut chart
                  DoughnutSeries<ChartData, String>(
                      innerRadius: '80%',
                      dataSource: chartData,
                      pointColorMapper: (ChartData data, _) => data.color,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y),

                ]),
            Center(

              child: Padding(
                padding: EdgeInsets.only(left:15, bottom: 130,),
                child: Text(

                  "      9 \nTasks left",
                  style: TextStyle(

                    fontSize: 30.0,
                    color: Colors.black,
                    // fontWeight: FontWeight.bold
                  ),
                ),
              ),
            )
          ],

        ),
//                       Row(
// children: [





//                         //  Icon(Icons.circle_rounded,color: Colors.red, ),
//                         //    Text('Completed'),
//                               ],



//                       ),

        // Text('Not Started'),
        //    Text('In Progress'),
        //       Text('Late'),
        // Container(color: Colors.green, height: 100),
        // ],
        //
      ),
    ),
    // ),
    JobScreen(),
    CompletedJobScreen(),
    account_screen()
  ];
  Future<void> setup()async{
    InitDatabase initDatabase=InitDatabase();
    initDatabase.setCollection='jobs';
    await initDatabase.addFromFile(filePath: jobsData, );

    initDatabase.setCollection='users';
    await initDatabase.addFromFile(filePath: usersData, );

    initDatabase.setCollection='service_tier';
    await initDatabase.addFromFile(filePath: serviceTierData, );

    initDatabase.setCollection='hotline';
    await initDatabase.addFromFile(filePath: hotLineData, );
  }

  final List<String> barTitle = [
    'Home',
    'Jobs',
    'Jobs',
    'Account'

  ];

  int index = 0;

  Future<void> fcm() async {
    PushNotificationRepos pushNotificationRepos = PushNotificationRepos();
    pushNotificationRepos.onMessage();
    String? myToken = await pushNotificationRepos.myFcmToken();
    FcmPayLoad fcmPayLoad = FcmPayLoad(title: 'riadh', body: 'gharbi');

    Future.delayed(const Duration(seconds: 5), () {
      pushNotificationRepos.sendNotification(
          userFcmToken: myToken!, fcmPayLoad: fcmPayLoad);
    });
  }

  @override
  void initState() {
    //setup();
    fcm();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(barTitle[index]),
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
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.call),
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //             builder: (BuildContext context) => const call_screen()));
      //   },
      //   backgroundColor: Colors.black,
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // bottomNavigationBar: BottomNavigationBar(
      //     type: BottomNavigationBarType.fixed,
      //     currentIndex: index,
      //     onTap: (page) {
      //       setState(() {
      //         index = page;
      //       });
      //     },
      //     items: const [
      //       BottomNavigationBarItem(
      //           icon: Icon(
      //             Icons.home,
      //             color: Colors.black,
      //           ),
      //           label: 'Home',
      //           backgroundColor: Colors.white),
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.pending_actions, color: Colors.black),
      //           label: 'Pending Jobs',
      //           backgroundColor: Colors.white),
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.task, color: Colors.black),
      //           label: 'Completed Jobs',
      //           backgroundColor: Colors.white),
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.person, color: Colors.black),
      //           label: 'Account',
      //           backgroundColor: Colors.white),
      //     ]),
      resizeToAvoidBottomInset: false,
      body: pages[index],
    );
  }
}

final List<ChartData> chartData = [
  ChartData('Completed', 2, Colors.green),
  ChartData('Not Started', 60, Colors.grey),
  ChartData('In Progress', 20, Colors.blueGrey),
  ChartData('Late', 12, Colors.red)
];

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
