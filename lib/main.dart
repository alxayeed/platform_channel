import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  String _batteryLevel = "0";

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
                Text('Battery Level: $_batteryLevel'),
                const SizedBox(height: 12.0),
                ElevatedButton(
                  onPressed: () {},
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
