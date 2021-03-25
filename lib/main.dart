import 'package:flutter/material.dart';
import 'package:sqlite/ModelClass/DBhelper.dart';

import 'desc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'Sqlite'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.id, this.text, this.desc})
      : super(key: key);
  final String title;
  final int id;
  final String text;
  final String desc;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
            FutureBuilder(
                future: dbhelper.instance.retrieveDBmodel(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (builder, index) {
                          return ListTile(
                            title: Text(snapshot.data[index].text),
                            subtitle: Text(snapshot.data[index].desc),
                            trailing: IconButton(
                                icon: Icon(
                              Icons.delete,
                            )),
                          );
                        });
                  } else {
                    return CircularProgressIndicator();
                  }
                }),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => desc()));
        },
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
