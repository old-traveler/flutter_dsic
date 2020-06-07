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
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        items: [
          DiscItem(
              value: 20,
              color: Color(0xfff79292),
              topText: '百度',
              bottomText: '26.56'),
          DiscItem(
              value: 30,
              color: Color(0xFFc1f5a4),
              topText: '腾讯',
              bottomText: '32.45'),
          DiscItem(
              value: 25,
              color: Color(0xff8ab8d9),
              topText: '美团',
              bottomText: '12.36'),
          DiscItem(
              value: 20,
              color: Color(0xfff79292),
              topText: 'Google',
              bottomText: '56.23'),
          DiscItem(
              value: 40,
              color: Color(0xff7cf2db),
              topText: '沃尔玛',
              bottomText: '45.56'),
          DiscItem(
              value: 40,
              color: Color(0xffce8bab),
              topText: '阿里巴巴',
              bottomText: '45.56'),
          DiscItem(
              value: 40,
              color: Color(0xfff79292),
              topText: '华为',
              bottomText: '45.56'),
          DiscItem(
              value: 40,
              color: Color(0xff8ab8d9),
              topText: '斗鱼',
              bottomText: '45.56'),
          DiscItem(
              value: 40,
              color: Color(0xFFc1f5a4),
              topText: '虎牙',
              bottomText: '45.56'),
          DiscItem(
              value: 40,
              color: Color(0xffce8bab),
              topText: '京东',
              bottomText: '45.56'),
          DiscItem(
              value: 40,
              color: Color(0xfff79292),
              topText: 'Windows',
              bottomText: '45.56'),
          DiscItem(
              value: 40,
              color: Color(0xff8ab8d9),
              topText: 'IBM',
              bottomText: '45.56'),
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
