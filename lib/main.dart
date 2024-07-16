import 'package:flutter/material.dart';
import 'package:aadl3dz/webview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AADL3 Inscription Helper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: const Color(0xFFFCBB00), // Yellow color from logo
        scaffoldBackgroundColor: const Color(0xFFF5F5F5), // Light background
        textTheme: const TextTheme(
          bodyMedium:
              TextStyle(color: Colors.black87), // Dark text color for contrast
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isMonitoring = false;

  void startMonitoring() {
    setState(() {
      isMonitoring = true;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CibWebWebViewPage(),
        ),
      );
    });
  }

  void stopMonitoring() {
    setState(() {
      isMonitoring = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/AADL_logo.png',
                width: 250,
                height: 250,
              ),
              const SizedBox(height: 70),
              Text(
                isMonitoring
                    ? 'Monitoring...'
                    : 'Press the button to start monitoring',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isMonitoring ? stopMonitoring : startMonitoring,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFFFCBB00), // Yellow color from logo
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 24.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  isMonitoring ? 'Stop Monitoring' : 'Start Monitoring',
                  style: const TextStyle(
                    color: Color(0xFF003366), // Dark blue from logo
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
