import 'package:flutter/material.dart';
import 'package:mobiili1/screens/paceCalc.dart';
import 'package:mobiili1/widgets/mainPageButton.dart';
import 'package:mobiili1/screens/shoePage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Container(
        child: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 85, 0, 30),
                child: Image(
                  image: AssetImage('assets/logo.png'),
                  width: 120,
                ),
              ),
              const Text(
                'Welcome.',
                style: TextStyle(fontSize: 32, letterSpacing: 1, height: 1.3),
              ),
              const Text('Choose here what to do.',
                  style:
                      TextStyle(fontSize: 18, letterSpacing: 1, height: 1.3)),
              MainPageButton(
                text: 'Manage Shoes',
                route: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ShoePage()),
                  );
                },
              ),
              MainPageButton(
                text: 'Pace Calculator',
                route: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PaceCalc()),
                  );
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
