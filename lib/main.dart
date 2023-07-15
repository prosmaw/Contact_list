import 'package:dac_test/models/database_helper.dart';
import 'package:dac_test/screens/home_screen.dart';
import 'package:dac_test/screens/search_page.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

late Database database;
DatabaseHelper dbhelper = DatabaseHelper();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  database = await dbhelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const HomeScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/searchPage': (context) => const SearchPage()
      },
    );
  }
}
