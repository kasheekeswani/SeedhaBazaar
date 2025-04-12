import 'package:flutter/material.dart';
import 'routes.dart'; // Create and manage all routes here
// ignore: unused_import
import 'home_page.dart';

void main() {
  runApp(const SeedhaBazaarApp());
}

class SeedhaBazaarApp extends StatelessWidget {
  const SeedhaBazaarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SeedhaBazaar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      initialRoute: '/home_page', // First page to show
      routes: appRoutes, // All routes defined in routes.dart
    );
  }
}