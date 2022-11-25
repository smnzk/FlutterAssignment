import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(115, 115, 115, 1),
      appBar: AppBar(
        title: const Center(
            child: Text('Rick and Morty character wiki',)
        ),
        backgroundColor: const Color.fromRGBO(128, 0, 64, 1),
      ),
    );
  }
}
