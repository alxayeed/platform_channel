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
  int batteryLevel = 0;

  final MethodChannel _methodChannel = const MethodChannel("com.practice.platformChannel");

  Future<void>getBatteryLevel() async{
    int _batteryLevel = await _methodChannel.invokeMethod("getBatteryLevel");
    setState(() {
      batteryLevel = _batteryLevel;
    });
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
                Text('Battery Level: ${batteryLevel.toString()}%'),
                const SizedBox(height: 12.0),
                ElevatedButton(
                  onPressed: getBatteryLevel,
                  child: const Text("Get Battery Level"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
