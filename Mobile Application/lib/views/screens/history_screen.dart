import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [
              0.07,
              0.2,
              0.4,
              0.6,
            ],
            colors: [
              Color.fromRGBO(158, 187, 104, 1),
              Color.fromRGBO(190, 216, 142, 1),
              Color.fromRGBO(231, 235, 225, 1),
              Colors.white,
            ],
          ),
          color: Colors.white,
        ),
      ),
    );
  }
}
