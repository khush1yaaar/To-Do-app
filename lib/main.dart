import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoappp/screens/auth/login_screen.dart';
import 'package:todoappp/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String? token; // Allow token to be nullable
  const MyApp({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    final bool isTokenValid = token != null && !JwtDecoder.isExpired(token!);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do App',
      theme: ThemeData(
        primaryColor: Colors.green,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
        ).copyWith(
          secondary: Colors.greenAccent, // Accent color
        ),
        scaffoldBackgroundColor: Colors.white, // Default background color
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green, // App bar background
          foregroundColor: Colors.white, // App bar text color
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.green, // FAB color
          foregroundColor: Colors.white, // FAB icon color
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green, // Elevated button color
            foregroundColor: Colors.white, // Button text color
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
          hintStyle: TextStyle(color: Colors.green),
        ),
      ),
      home: isTokenValid ? HomeScreen(token: token!) : LoginScreen(),
    );
  }
}
