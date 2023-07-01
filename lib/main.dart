import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _batteryLevel = 0;
  Stream<double> _barometerStream = const Stream.empty();

  final MethodChannel _methodChannel = const MethodChannel("com.practice.platformChannel/methodChannel");
  final EventChannel _eventChannel = const EventChannel("com.practice.platformChannel/eventChannel");

  Future<void>getBatteryLevel() async{
    int batteryLevel = await _methodChannel.invokeMethod("getBatteryLevel");
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  Future<bool> initializeBarometer()async {
    return await _methodChannel.invokeMethod("initializeBarometer");
  }

 Stream<double> pressureStream(){
    _barometerStream = _eventChannel.receiveBroadcastStream()
        .map<double>((value) => value);

    return _barometerStream;
 }

 @override
  void initState() {
    super.initState();
    initializeBarometer();
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Battery Level: ${_batteryLevel.toString()}%'),
                const SizedBox(height: 12.0),
                ElevatedButton(
                  onPressed: getBatteryLevel,
                  child: const Text("Get Battery Level"),
                ),
                const SizedBox(height: 12.0),
                StreamBuilder(
                  stream: pressureStream(),
                    builder: (BuildContext context, AsyncSnapshot<double> snapshot){
                        if(snapshot.hasData){
                          return Text('Pressure Level: ${snapshot.data}');
                        }
                        return const Text("No Pressure detected!");
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
