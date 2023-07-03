import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TestNo extends StatefulWidget {
  String? errorCode;

  TestNo({Key? key, this.errorCode}) : super(key: key);

  @override
  State<TestNo> createState() => _TestNoState();
}

class _TestNoState extends State<TestNo> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset("assets/images/3_Something Went Wrong.png", fit: BoxFit.cover),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.19,
          left: MediaQuery.of(context).size.width * 0.13,
          right: MediaQuery.of(context).size.width * 0.13,
          child: ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF70DAAD),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              ),
              child: widget.errorCode != null
                  ? Text(
                      'Error Code is ${widget.errorCode?.toString()}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
                    )
                  : Text(
                      'Unknown error or your device is not connected to the Internet',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    )),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.13,
          left: MediaQuery.of(context).size.width * 0.3,
          right: MediaQuery.of(context).size.width * 0.3,
          child: ElevatedButton(
            child: Text(
              "Try Again".toUpperCase(),
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              setState(() {});
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF70DAAD),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            ),
          ),
        ),
      ],
    );
  }
}
