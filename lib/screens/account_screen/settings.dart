import 'package:flutter/material.dart';

class settings_screen extends StatefulWidget {
  const settings_screen({Key? key}) : super(key: key);

  @override
  _settings_screenState createState() => _settings_screenState();
}

class _settings_screenState extends State<settings_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Header
      appBar: AppBar(
          backgroundColor: Color(0xff2A4D69),
          automaticallyImplyLeading: true,
          title: Text("Settings"),
      ),

        // Main Content
        body: Column(
          children: [
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.language, size: 35,),
              title: Text("Language", style: TextStyle(fontSize: 18),),
              onTap: () {},
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.color_lens, size: 35,),
              title: Text("Theme Color", style: TextStyle(fontSize: 18),),
              onTap: () {},
            )
          ],
        ),

    );
  }
}
