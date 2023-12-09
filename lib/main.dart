import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:stock_scan_parser/constants/routes.dart';
import 'package:stock_scan_parser/screens/backend_down_screen.dart';
import 'package:stock_scan_parser/screens/no_internet.dart';
import 'package:stock_scan_parser/screens/pages/home_page.dart';
import 'package:stock_scan_parser/screens/pages/stock_scan_detail.dart';
import 'package:stock_scan_parser/screens/pages/variable_detail_page.dart';
import 'package:stock_scan_parser/services/apiService.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // check backend status
  Future<bool> checkBackendStatus() async {
    bool isBackendLive = await getBackendStatusAPI();
    return isBackendLive;
  }

  // check internet connectivity
  Future<bool> checkInternetConnectivity() async {
    final isConnected = await InternetConnectionChecker().hasConnection;
    return isConnected;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF040D12),
        appBarTheme: const AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,

      // Splash Screen
      home: AnimatedSplashScreen(
        duration: 3000,
        splash: const Icon(
          Icons.currency_rupee,
          size: 25,
        ),
        splashIconSize: 200,
        nextScreen: FutureBuilder<Widget>(
          future: _checkConnectivity(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasData) {
              return snapshot.data!;
            } else {
              return const BackendDownScreen();
            }
          },
        ),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.black,
      ),

      // routes
      routes: {
        homePageRoute: (context) => const HomePage(),
        stockScanDetailRoute: (context) => StockScanDetail(
            stockScan: ModalRoute.of(context)!.settings.arguments),
        variableDetailRoute: (context) {
          final arguments = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return VariableDeatil(
            variable: arguments["variable"] as Map<String, dynamic>,
            type: arguments["type"] as String,
            title: arguments["title"] as String,
          );
        },
      },
    );
  }

  // check connectivity and backend status
  Future<Widget> _checkConnectivity() async {
    bool isConnected = await checkInternetConnectivity();
    bool isBackendLive = await checkBackendStatus();

    if (!isConnected) {
      return const NoInternetScreen();
    } else if (!isBackendLive) {
      return const BackendDownScreen();
    } else {
      return const HomePage();
    }
  }
}
