import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:audioplayers/audioplayers.dart';

class CibWebWebViewPage extends StatefulWidget {
  const CibWebWebViewPage({Key? key}) : super(key: key);

  @override
  _CibWebWebViewPageState createState() => _CibWebWebViewPageState();
}

class _CibWebWebViewPageState extends State<CibWebWebViewPage> {
  late WebViewController _controller;
  Timer? _reloadTimer;
  bool _isWebsiteLoaded = false;
  bool _isLoading = true;
  bool _isOffline = false;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _initializeWebView();

    _reloadTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!_isWebsiteLoaded && !_isOffline) {
        _controller.reload();
        setState(() {
          _isLoading = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Reloading...'),
          ),
        );
        if (kDebugMode) {
          print("reloading...");
        }
      }
    });

    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() {
        _isOffline = result == ConnectivityResult.none;
      });
      if (_isOffline) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No internet connection.'),
          ),
        );
      }
    });
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(_buildNavigationDelegate())
      ..loadRequest(Uri.parse("https://aadl3inscription2024.dz"));
  }

  void _pressStartTheInscriptionButton() {
    _controller.runJavaScript(
      """
     
      document.getElementById('A14').click(); 
      """,
    ).catchError((error) {
      debugPrint('Error injecting autofill data: $error');
    });
  }

  void _autofillUserDetails() {
    _controller.runJavaScript(
      """
      
      document.getElementById('A22').value = '1234567890123456789';
      document.getElementById('A27').value = '987654321098';
      document.getElementById('A13').value = '0541074913';
     
      """,
    ).catchError((error) {
      debugPrint('Error injecting autofill data: $error');
    });
  }

  NavigationDelegate _buildNavigationDelegate() {
    return NavigationDelegate(
      onProgress: (int progress) {
        setState(() {
          _isLoading = progress < 100;
        });
        debugPrint('Loading: $progress%');
      },
      onPageStarted: (String url) {
        setState(() {
          _isLoading = true;
        });
        debugPrint("onPageStarted");
      },
      onPageFinished: (String url) {
        setState(() {
          _isLoading = false;
        });
        debugPrint('onPageFinished $url');
        _handlePageFinished(url);
      },
      onWebResourceError: (WebResourceError error) {
        debugPrint('WebResourceError: $error');
        _handleWebResourceError(error);
      },
      onNavigationRequest: (NavigationRequest request) {
        debugPrint('NavigationRequest: $request');
        return NavigationDecision.navigate;
      },
    );
  }

  @override
  void dispose() {
    _reloadTimer?.cancel();
    _connectivitySubscription.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _handlePageFinished(String url) {
    if (_isErrorPage(url)) {
      setState(() {
        _isWebsiteLoaded = false;
        _isLoading = true;
      });
      _clearCacheAndReload();
    } else if (url.contains("AR")) {
      setState(() {
        _isWebsiteLoaded = true;
      });
      _reloadTimer?.cancel();
      _playNotificationSound();

      //This presses the home screen button that will navigate the user to the inscription page
      _pressStartTheInscriptionButton();
      Future.delayed(const Duration(seconds: 2));

      //This will autofill the most important long form fields
      _autofillUserDetails();

      if (kDebugMode) {
        print("Website loaded successfully.");
      }
    }
  }

  bool _isErrorPage(String url) {
    // Add more comprehensive checks if necessary
    const errorKeywords = [
      'ERR_CONNECTION_TIMED_OUT',
      'ERR_NAME_NOT_RESOLVED',
      'ERR_INTERNET_DISCONNECTED',
      'ERR_CONNECTION_RESET'
    ];
    return errorKeywords.any((keyword) => url.contains(keyword));
  }

  void _handleWebResourceError(WebResourceError error) {
    setState(() {
      _isWebsiteLoaded = false;
      _isLoading = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: ${error.description}. Retrying...'),
      ),
    );

    if (error.errorType == WebResourceErrorType.timeout) {
      _clearCacheAndReload();
    } else {
      _controller.reload();
    }
  }

  void _clearCacheAndReload() async {
    await _controller.clearCache();
    await _controller.loadRequest(Uri.parse("https://aadl3inscription2024.dz"));
  }

  void _playNotificationSound() async {
    await _audioPlayer.setSource(AssetSource('notification.mp3'));
    await _audioPlayer.resume();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AADL3 Website',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          if (_isOffline)
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Container(
                color: Colors.redAccent,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'You are offline',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
