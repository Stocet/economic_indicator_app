import 'dart:convert';
import 'data/models/indicator.dart';
import 'presentation/screens/about_screen.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/indicator_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Offline fallback is handled by loading the local assets/indicators.json file.
  // In a real-world app, you would have a function here to fetch from a backend,
  // and use a try-catch block to fall back to this local file if the fetch fails.
  List<Indicator> indicators = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadIndicators();
  }

  Future<void> _loadIndicators() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/indicators.json',
      );
      final List<dynamic> data = json.decode(response);
      setState(() {
        indicators = data.map((json) => Indicator.fromJson(json)).toList();
        isLoading = false;
      });
    } catch (e) {
      // Handle the case where the local file can't be loaded (e.g., file not found).
      // For this example, we'll just print an error.
      // print('Error loading indicators: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Economic Indicators',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFE2B800),
        scaffoldBackgroundColor: const Color(0xFF1E2125),
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFFE2B800),
          secondary: const Color(0xFFB8B8B8),
          surface: const Color(0xFF2D3035),
          onSurface: Colors.white,
        ),
        fontFamily: GoogleFonts.inter().fontFamily,
        cardTheme: CardTheme(
          color: const Color(0xFF2D3035),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E2125),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      home:
          isLoading
              ? const Scaffold(body: Center(child: CircularProgressIndicator()))
              : MainApp(indicators: indicators),
    );
  }
}

class MainApp extends StatefulWidget {
  final List<Indicator> indicators;
  const MainApp({super.key, required this.indicators});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      const HomeScreen(),
      IndicatorsScreen(allIndicators: widget.indicators),
      const AboutScreen(),
    ];

    return Scaffold(
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).cardTheme.color,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
            activeIcon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: 'Indicators',
            activeIcon: Icon(Icons.bar_chart),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'About',
            activeIcon: Icon(Icons.info),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
