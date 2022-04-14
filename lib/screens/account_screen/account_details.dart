import 'package:flutter/material.dart';
import 'package:i_logistics/screens/account_screen/tabs/company.dart';
import 'package:i_logistics/screens/account_screen/tabs/emergency.dart';
import 'package:i_logistics/screens/account_screen/tabs/personal.dart';
import 'package:i_logistics/screens/account_screen/tabs/vehicle.dart';


class account_details extends StatefulWidget {
  const account_details({Key? key}) : super(key: key);

  @override
  State<account_details> createState() => _account_detailsState();
}

class _account_detailsState extends State<account_details> {
  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: 4,
    child: Scaffold(

      // Header
      appBar: AppBar(
        backgroundColor: Color(0xff2A4D69),
        title: Text("View Profile"),
        automaticallyImplyLeading: true,
        bottom: TabBar(
          indicatorColor: Colors.white,
          indicatorWeight: 5,
          tabs: [
            Tab(text: "Personal", icon: Icon(Icons.person)),
            Tab(text: "Company", icon: Icon(Icons.work)),
            Tab(text: "Vehicle", icon: Icon(Icons.directions_car)),
            Tab(text: "Emergency", icon: Icon(Icons.people)),
          ],
        ),
      ),

      // Content
      body: TabBarView(
        children: [
          account_details_personal(),
          account_details_company(),
          account_details_vehicle(),
          account_details_emergency(),
        ],
      ),

    ),
  );
}
