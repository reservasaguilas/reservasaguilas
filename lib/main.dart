import 'package:flutter/material.dart';
import 'package:reservasaguilas/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reservas Aguilas de Piedra',
      theme: ThemeData(
        accentColor: Color.fromRGBO(72, 202, 228, 1),
        primaryColor: Color.fromRGBO(72, 202, 228, 1),
        backgroundColor: Color.fromRGBO(255, 229, 217, 1),
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}