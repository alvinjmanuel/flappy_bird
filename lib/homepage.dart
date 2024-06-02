import 'package:flutter/material.dart';
import 'main_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: const Color(0xff70C4CF),
              child: Image.asset('images/flappy1.jpg'),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: const Color(0xff70C4CF),
              child: Image.asset('images/logo.png'),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              color: const Color(0xffDED793),
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext) => MainPage(),),);
                },
                child: Image.asset('images/Play1.png'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
