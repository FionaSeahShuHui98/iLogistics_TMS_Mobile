import 'package:flutter/material.dart';
import 'package:i_logistics/screens/account_screen/account_main.dart';
import 'package:i_logistics/screens/call_screen/call_main.dart';
import 'package:i_logistics/screens/completed_jobs_screen/completed_job_screen.dart';
import 'package:i_logistics/screens/home_screen/home_screen.dart';
import 'package:i_logistics/screens/pending_jobs_screen/job_screen.dart';

class navigation_bar extends StatefulWidget {
  @override
  _navigation_barState createState() => _navigation_barState();
}

class _navigation_barState extends State<navigation_bar> {
  //Declaration
  int currentTab = 0;
  final PageStorageBucket page = PageStorageBucket();

  // Types of screen
  final List<Widget> screens = [
    HomeScreen(),
    JobScreen(),
    CompletedJobScreen(),
    account_screen(),
  ];

  // Setting of home page
  Widget currentScreen = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: page,
      ),

      // Call Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff2A4D69),
        child: Icon(
          Icons.phone,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => call_screen(),
          ),);
        },
      ),
      // Postition of Call Button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Bottom Navigation Bar
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Home & Pending Jobs Button
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Home Button
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = HomeScreen();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color:
                              currentTab == 0 ? Color(0xff2A4D69) : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: currentTab == 0
                                ? Color(0xff2A4D69)
                                : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),

                  // Pending Jobs Button
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = JobScreen();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.pending_actions,
                          color:
                              currentTab == 1 ? Color(0xff2A4D69) : Colors.grey,
                        ),
                        Text(
                          'Pending',
                          style: TextStyle(
                            color: currentTab == 1
                                ? Color(0xff2A4D69)
                                : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),

              // Completed Jobs & Account Button
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Completed Jobs Button
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = CompletedJobScreen();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.done_outline,
                          color:
                              currentTab == 2 ? Color(0xff2A4D69) : Colors.grey,
                        ),
                        Text(
                          'Completed',
                          style: TextStyle(
                            color: currentTab == 2
                                ? Color(0xff2A4D69)
                                : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),

                  // Account Button
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = account_screen();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color:
                              currentTab == 3 ? Color(0xff2A4D69) : Colors.grey,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                            color: currentTab == 3
                                ? Color(0xff2A4D69)
                                : Colors.grey,
                          ),
                        )
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
