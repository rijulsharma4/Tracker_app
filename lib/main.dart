import 'package:flutter/material.dart';
import 'package:tracker_app/screens/home_screen.dart';


void main() {
runApp(const TrackerApp());
}


class TrackerApp extends StatelessWidget {
const TrackerApp({super.key});


@override
Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,
title: 'Tracker App',
theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
home: const HomeScreen(),
);
}
}