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
            padding: EdgeInsets.symmetric(vertical: 50,horizontal: 20),
            items: [
              DiscItem(
                  value: 20,
                  color: Colors.red,
                  topText: '小胖子',
                  bottomText: '92kg'),
              DiscItem(
                  value: 30,
                  color: Colors.blue,
                  topText: '小帅哥',
                  bottomText: '90kg'),
              DiscItem(
                  value: 25,
                  color: Colors.amber,
                  topText: '杨小胖',
                  bottomText: '100kg'),
              DiscItem(
                  value: 20,
                  color: Colors.deepOrangeAccent,
                  topText: '小小胖',
                  bottomText: '999kg'),
              DiscItem(
                  value: 40,
                  color: Colors.lightGreen,
                  topText: '小胖小胖',
                  bottomText: '555kg'),
            ],
            duration: Duration(milliseconds: 2000),
            radius: 80,
            strokeWidth: 28,
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
