import 'package:flutter/material.dart';
import 'package:sqlite/ModelClass/DBhelper.dart';
import 'package:sqlite/ModelClass/ModelClass.dart';

class desc extends StatefulWidget {
  desc({Key key, this.title}) : super(key: key);
  final String title;


  @override
  descState createState() => descState();
}

class descState extends State<desc> {
  final TextEditingController textEC = TextEditingController();
  final TextEditingController descEC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50.0,),
            TextField(
              controller: textEC,
              decoration: InputDecoration(hintText: "Title"),),
            SizedBox(height: 25.0,),
            TextField(
              controller: descEC,
              decoration: InputDecoration(hintText: "desc"),),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (DBmodel == null) {
            dbhelper.instance.insertDBmodel(DBmodel(
              text: textEC.text,
              desc: descEC.text
            ));
            Navigator.pop(context,"saved");
          }
          else{
            await dbhelper.instance.updateDBmodel(DBmodel(text: textEC.text,desc: descEC.text));
            Navigator.pop(context);
          }
          setState(() {

          });
        },
      ),
    );
  }
}
