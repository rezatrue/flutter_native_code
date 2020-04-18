import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Native Code',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _batteryLevel;

  Future<void> _getBatteryLevel() async {
    const platform = MethodChannel('course.flutter.dev/battery');
    try{
    final batteryLevel = await platform.invokeMethod('getBatterLevel');
    setState(() {
      print('set ------');
      _batteryLevel = batteryLevel;
    });
    }on PlatformException catch (error){
      setState(() {
        print('set ------' + error.message);
      _batteryLevel = null;
    });
    }

  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Native Code'),
      ),
      body: Column(
        children: <Widget>[
          FlatButton(onPressed: _getBatteryLevel, child: Text('get')),
          Center(child: Text('Battery level : $_batteryLevel'),),
        ],
      ),
      
    );
  }
}
