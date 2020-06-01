import 'package:flutter/material.dart';
import 'package:flutter_dsic/disc_item.dart';
import 'package:flutter_dsic/dsic.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
          child: Disc(
        items: [
          DiscItem(value: 20, color: Colors.red),
          DiscItem(value: 30, color: Colors.blue),
          DiscItem(value: 25, color: Colors.amber),
          DiscItem(value: 20, color: Colors.deepOrangeAccent),
          DiscItem(value: 40, color: Colors.lightGreen),
        ],
        duration: Duration(milliseconds: 1000),
        radius: 100,
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
