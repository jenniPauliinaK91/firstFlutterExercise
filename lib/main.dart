import 'package:flutter/material.dart';
import 'package:mobiili1/screens/mainPage.dart';
import 'package:mobiili1/widgets/showLogo.dart';

void main() {
  runApp(const MaterialApp(
    title: 'My Shoe App',
    debugShowCheckedModeBanner: false,
    home: ShoeApp(),
  ));
}

class ShoeApp extends StatefulWidget {
  const ShoeApp({Key? key}) : super(key: key);

  @override
  _ShoeAppState createState() => _ShoeAppState();
}

class _ShoeAppState extends State<ShoeApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/tausta2.jpg'),
            fit: BoxFit.cover,
          )),
          child: Column(children: [
            Container(
              child: ShowLogo(width: 150),
              margin: const EdgeInsets.only(top: 90),
            ),
            Container(
              margin: const EdgeInsets.only(top: 260),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(240, 60),
                      primary: const Color(0xFFF3F3F3).withOpacity(0.4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      textStyle: const TextStyle(
                        fontSize: 20,
                      )),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MainPage()),
                    );
                  },
                  child: const Text('Go to App')),
            ),
          ])),
    );
  }
}
