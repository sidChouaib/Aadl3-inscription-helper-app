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
      title: 'AADL3 Inscription helper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Colors.yellow, // Accent color for the app
        scaffoldBackgroundColor: Colors.blue.shade900, // Dark blue background
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white), // Text color
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
          builder: (context) => CibWebWebViewPage(),
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                backgroundColor: Colors.yellow, // Yellow button color
              ),
              child: Text(
                isMonitoring ? 'Stop Monitoring' : 'Start Monitoring',
                style: TextStyle(
                    color: Colors.blue.shade900), // Dark blue text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:aadl3dz/webview.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'AADL3 Inscription helper',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         hintColor: Colors.yellow, // Accent color for the app
//         scaffoldBackgroundColor: Colors.blue.shade900, // Dark blue background
//         textTheme: const TextTheme(
//           bodyMedium: TextStyle(color: Colors.white), // Text color
//         ),
//       ),
//       home: const HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   bool isMonitoring = false;

//   void startMonitoring() {
//     setState(() {
//       isMonitoring = true;
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => CibWebWebViewPage(),
//         ),
//       );
//     });
//   }

//   void stopMonitoring() {
//     setState(() {
//       isMonitoring = false;
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               isMonitoring
//                   ? 'Monitoring...'
//                   : 'Press the button to start monitoring',
//               style: const TextStyle(fontSize: 18),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: isMonitoring ? stopMonitoring : startMonitoring,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.yellow, // Yellow button color
//               ),
//               child: Text(
//                 isMonitoring ? 'Stop Monitoring' : 'Start Monitoring',
//                 style: TextStyle(
//                     color: Colors.blue.shade900), // Dark blue text color
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
