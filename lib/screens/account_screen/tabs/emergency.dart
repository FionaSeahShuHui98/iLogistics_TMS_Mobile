import 'package:flutter/material.dart';

class account_details_emergency extends StatefulWidget {
  const account_details_emergency({Key? key}) : super(key: key);

  @override
  State<account_details_emergency> createState() => _account_details_emergencyState();
}

class _account_details_emergencyState extends State<account_details_emergency> {
  // Functions - Handphone Number
  handphone_number(BuildContext context) {
    TextEditingController customController = TextEditingController();
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Update Mobile Number"),
        content: TextField(
          decoration: InputDecoration(
              hintText: "New Handphone Number"
          ),
          controller: customController,
          keyboardType: TextInputType.phone,
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () {Navigator.of(context).pop(context);},
            icon: Icon(Icons.cancel),
            label: Text(
              "Cancel",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            style: ElevatedButton.styleFrom(
                primary: Color(0xffDC3545),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {Navigator.of(context).pop(context);},
            icon: Icon(Icons.change_circle_sharp),
            label: Text(
              "Confirm",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            style: ElevatedButton.styleFrom(
                primary: Color(0xff2A4D69),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )
            ),
          ),
        ],
      );
    });
  }

  // Functions - Name
  name(BuildContext context) {
    TextEditingController customController = TextEditingController();
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Update Emergency Contact Name"),
        content: TextField(
          decoration: InputDecoration(
              hintText: "Name"
          ),
          controller: customController,
          //keyboardType: TextInputType.phone,
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () {Navigator.of(context).pop(context);},
            icon: Icon(Icons.cancel),
            label: Text(
              "Cancel",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            style: ElevatedButton.styleFrom(
                primary: Color(0xffDC3545),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {Navigator.of(context).pop(context);},
            icon: Icon(Icons.change_circle_sharp),
            label: Text(
              "Confirm",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            style: ElevatedButton.styleFrom(
                primary: Color(0xff2A4D69),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )
            ),
          ),
        ],
      );
    });
  }

  // Functions - Address
  address(BuildContext context) {
    TextEditingController customController = TextEditingController();
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Update Emergency Contact Address"),
        content: TextField(
          decoration: InputDecoration(
              hintText: "Address"
          ),
          controller: customController,
          //keyboardType: TextInputType.phone,
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () {Navigator.of(context).pop(context);},
            icon: Icon(Icons.cancel),
            label: Text(
              "Cancel",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            style: ElevatedButton.styleFrom(
                primary: Color(0xffDC3545),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {Navigator.of(context).pop(context);},
            icon: Icon(Icons.change_circle_sharp),
            label: Text(
              "Confirm",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            style: ElevatedButton.styleFrom(
                primary: Color(0xff2A4D69),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )
            ),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        // Name
        Row(
            children:[
              Container(
                padding: EdgeInsets.only(top: 30, left: 20),
                child: Text("NAME",style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: EdgeInsets.only(top: 30, left: 30),
                child: Text("CHAN HUI YU"),
              ),
              Container(
                padding: EdgeInsets.only(top: 30, left: 160),
                child: IconButton(
                  onPressed: () {name(context);},
                  icon: Icon(Icons.edit),
                ),
              )
            ]
        ),

        // Mobile Number
        Row(
            children:[
              Container(
                padding: EdgeInsets.only(top: 30, left: 20),
                child: Text("MOBILE NO",style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: EdgeInsets.only(top: 30, left: 30),
                child: Text("945457654"),
              ),
              Container(
                padding: EdgeInsets.only(top: 30, left: 140),
                child: IconButton(
                  onPressed: () {handphone_number(context);},
                  icon: Icon(Icons.edit),
                ),
              )
            ]
        ),

        // Address
        Row(
            children:[
              Container(
                padding: EdgeInsets.only(top: 30, left: 20),
                child: Text("ADDRESS",style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: EdgeInsets.only(top: 30, left: 30),
                child: Text("LOR AH SOO \nBLK 137 APT #05-531, \nSINGAPORE 530117"),
              ),
              Container(
                padding: EdgeInsets.only(top: 30, left: 80),
                child: IconButton(
                  onPressed: () {address(context);},
                  icon: Icon(Icons.edit),
                ),
              )
            ]
        ),
      ],
    );
  }
}
