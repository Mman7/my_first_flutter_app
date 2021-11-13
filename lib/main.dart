import 'dart:math';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyFirstApp());
}

class MyFirstApp extends StatelessWidget {
  const MyFirstApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Suck My Cat',
        home: SafeArea(
          child: Scaffold(
            body: MeowContainer(),
          ),
        ));
  }
}

class MeowContainer extends StatefulWidget {
  const MeowContainer({Key? key}) : super(key: key);

  @override
  _MeowContainerState createState() => _MeowContainerState();
}

class _MeowContainerState extends State<MeowContainer> {
  int _count = 0;
  bool changePic = false;
  String hexColor = 'ffffff';

  void _addCounter() async {
    setState(() {
      _count++;
      changePic = !changePic;
      Color _randomColor =
          Colors.primaries[new Random().nextInt(Colors.primaries.length)];
      final _hexColor = _randomColor.value.toRadixString(16);
      hexColor = _hexColor;
      _incrementCounter(_count);
    });
  }

  @override
  void initState() {
    dynamic data = getCounter().then((data) => setState(() {
          _count = data;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            TextButton(
              onPressed: _addCounter,
              child: Image(
                image: changePic
                    ? AssetImage('assets/PopCats/pop2.png')
                    : AssetImage('assets/PopCats/pop1.png'),
              ),
            ),
            Text(
              '$_count',
              style: TextStyle(color: HexColor('$hexColor'), fontSize: 50),
            )
          ],
        ));
  }
}

Future<int> getCounter() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int counterValue = prefs.getInt('counter') ?? 0;
  return counterValue;
}

_incrementCounter(value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('counter', value);
}
