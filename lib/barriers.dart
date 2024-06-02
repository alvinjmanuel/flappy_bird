import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {

  final size;
  MyBarrier({this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(width: 5,color: const Color.fromARGB(255, 4, 66, 36)),
        borderRadius: BorderRadius.circular(5)
      ),
    );
  }
}