import 'package:flutter/material.dart';

class NoConnectionScreen extends StatefulWidget {
  @override
  State<NoConnectionScreen> createState() => _NoConnectionScreenState();
}

class _NoConnectionScreenState extends State<NoConnectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/img.png", fit: BoxFit.cover),
          Positioned(
            bottom: 100,
            left: 30,
            child: ElevatedButton(
              child: Text("Retry".toUpperCase()),
              onPressed: () {
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
