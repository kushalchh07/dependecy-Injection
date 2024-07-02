// ignore_for_file: prefer_const_constructors

import 'package:dependency_injection/services/appservice.dart';
import 'package:dependency_injection/utils/injection_contianer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  String currentDate = locator<AppService>().getDate();
                  print(currentDate);

                  final snackBar = SnackBar(
                    content: Text(currentDate),
                    duration: Duration(seconds: 10),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Text("Get DAte")),
          ],
        ),
      ),
    );
  }
}
