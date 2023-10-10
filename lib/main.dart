import 'package:dio_sample/services/api.dart';
import 'package:dio_sample/services/store.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final api = DemoAPI();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    final bool result = await api.dioLogin();
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('The Result of dio login is $result')));
                    }
                  },
                  child: const Text('Login')),
              ElevatedButton(
                  onPressed: () async {
                    final String result = await api.dioGetData();
                    if (mounted) {
                      debugPrint("('The Result of dio login is $result')");
                    }
                  },
                  child: const Text('Get Auth Data')),
              ElevatedButton(
                  onPressed: () async {
                    await Store.clear();
                  },
                  child: const Text('Clear Auth'))
            ],
          ),
        ),
      ),
    );
  }
}
