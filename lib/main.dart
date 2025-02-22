import 'package:flutter/material.dart';
import 'splash_screen.dart'; // Importando a SplashScreen corretamente

void main() {
  runApp(DimensionadorApp());
}

class DimensionadorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dimensionador de Projetos',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(), // Define a SplashScreen como tela inicial
    );
  }
}
