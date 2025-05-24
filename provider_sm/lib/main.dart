import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'font_size_model.dart';
import 'font_size_screen.dart'; // Import the model

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => FontSizeModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider Font Size',
      home: Scaffold(
        appBar: AppBar(title: const Text('Provider - Font Size')),
        body: const FontSizeScreen(),
      ),
    );
  }
}
