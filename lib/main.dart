import 'package:flutter/material.dart';
import 'package:gok_project/edit.dart';
import 'package:gok_project/lectie_experimental.dart';
import 'package:gok_project/responsive.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyCb6OoI0HG1Eb2TDqrpBKvTWY6afjxYS18",
        appId: "1:646031345974:web:b95cd6332343ca1fb68b97",
        messagingSenderId: "646031345974",
        projectId: "gok-project-67e18"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guardians of Knowledge - Demo',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'PixelText2'),
      home: const MyHomePage(title: 'Guardians of Knowledge - Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Image buttonImage = Image(image: AssetImage('assets/img/buton_next.png'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        // Fundalul
        Container(
          width: MediaQuery.of(context).size.width,
          child: Image(
            image: AssetImage('assets/img/fundal_noapte.jpg'),
            fit: BoxFit.fitWidth,
          ),
        ),

        // Con'inut
        Column(
          children: [
            ResponsiveLayout.isLargeScreen(context)
                ? Text(
                    'Apasă pe buton pentru a începe o lecție',
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  )
                : ResponsiveLayout.isMediumScreen(context)
                    ? Text(
                        'Website-ul încă nu este optimizat pentru ecran mediu, de genu tabletă',
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )
                    : Text(
                        'Website-ul nu e optimizat pentru telefoane mobile sau ecrane mici',
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
            InkWell(
              onHover: ((value) {
                setState(() {
                  if (value == true) {
                    buttonImage = Image(
                        image: AssetImage('assets/img/buton_next_animat.gif'));
                  } else {
                    buttonImage =
                        Image(image: AssetImage('assets/img/buton_next.png'));
                  }
                });
              }),
              onTap: () {
                print('tap');
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => new ExperimentalList(),
                  ),
                );
              },
              child: buttonImage,
            ),
            InkWell(
              onTap: () {
                print('tap buton 2');
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => new EditPage(),
                  ),
                );
              },
              child: Text(
                'Editează lecția',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        )
      ],
    ));
  }
}
