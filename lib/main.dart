import 'package:activity_click/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  runApp(MultiProvider(providers: providers, child: const MainApp()));
}

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<ActivityDataProvider>(
      create: (_) => ActivityDataProvider()),
  Provider<bool>(create: ((context) => true)),
];

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity Click',
      theme: ThemeData(useMaterial3: true),
      home: Home(),
    );
  }
}
