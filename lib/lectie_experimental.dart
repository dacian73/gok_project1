import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:math' as math;
import 'package:gok_project/storage/storage.dart';

class ExperimentalList extends StatefulWidget {
  const ExperimentalList({super.key});

  @override
  State<ExperimentalList> createState() => _ExperimentalListState();
}

class _ExperimentalListState extends State<ExperimentalList> {
  Image buttonImage = Image(image: AssetImage('assets/img/buton_next.png'));
  int pasLectie = 1;
  ScrollController _scrollController = new ScrollController();
  crudMedthods crud = new crudMedthods();
  String titlu = '';

  @override
  Widget build(BuildContext context) {
    updateFromFirebase();

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            width: MediaQuery.of(context).size.width,
            child: Image(
              image: AssetImage('assets/img/fundal_noapte.jpg'),
              fit: BoxFit.fitWidth,
            ),
          ),
          //Conținutul lecției
          Center(
            child: Container(
                width: 1000,
                child: ListView(
                  controller: _scrollController,
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      height: 100,
                    ),
                    tabla_structura_atom(),
                    if (pasLectie == 1) butonNext(),
                    if (pasLectie > 1) tabla_masa_atomica(),
                    if (pasLectie == 2) butonNext(),
                    if (pasLectie > 2) tabla_structura_atom(),
                    if (pasLectie == 3) butonNext(),
                    if (pasLectie > 3) tabla_structura_atom(),
                    if (pasLectie == 4) butonNext(),
                    if (pasLectie > 4) tabla_masa_atomica(),
                    Container(
                      height: 200,
                    ),
                    if (pasLectie < 3)
                      Container(
                        height: 500,
                      )
                  ],
                )),
          ),
        ],
      ),
    );
  }

  butonNext() {
    return Container(
      height: 80,
      child: InkWell(
        onHover: ((value) {
          setState(() {
            if (value == true) {
              buttonImage =
                  Image(image: AssetImage('assets/img/buton_next_animat.gif'));
            } else {
              buttonImage =
                  Image(image: AssetImage('assets/img/buton_next.png'));
            }
          });
        }),
        onTap: () {
          setState(() {
            pasLectie = pasLectie + 1;
          });
          SchedulerBinding.instance.addPostFrameCallback((_) {
            _scrollController
                .jumpTo(_scrollController.position.maxScrollExtent);
          });
          print('tap');
        },
        child: buttonImage,
      ),
    );
  }

  Future<void> updateFromFirebase() async {
    String NEWtitlu = '';
    DocumentSnapshot documentSnapshot = await crud.getData('lectie');
    NEWtitlu = documentSnapshot.get('titlu');
    setState(() {
      titlu = NEWtitlu;
    });
  }

  tabla_masa_atomica() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      width: 800,
      child: Stack(
        children: [
          Center(
            child: Image(
              image: AssetImage('assets/img/masa_atomica.png'),
              width: 800,
            ),
          ),
          Positioned(
              top: 2,
              left: 140,
              child: Text(
                'Masa atomică',
                style: TextStyle(
                  fontSize: 34,
                  color: Colors.white,
                ),
              )),
          Positioned(
            left: 120,
            top: 70,
            child: Text(
              'Protoni',
              style: TextStyle(fontSize: 75),
            ),
          ),
          Positioned(
            left: 120,
            top: 200,
            child: Text(
              'Neurtoni',
              style: TextStyle(fontSize: 75),
            ),
          ),
          Positioned(
              left: 120,
              top: 330,
              child: Text('Electroni', style: TextStyle(fontSize: 75))),
          Positioned(
              left: 470,
              top: 70,
              child: Text('1,6726x10⁻²⁷ kg',
                  style: TextStyle(
                    fontSize: 75,
                    color: Colors.white,
                  ))),
          Positioned(
              left: 470,
              top: 200,
              child: Text('1,6749x10⁻²⁷ kg',
                  style: TextStyle(
                    fontSize: 75,
                    color: Colors.white,
                  ))),
          Positioned(
              left: 470,
              top: 330,
              child: Text('9,109x10⁻³¹ kg',
                  style: TextStyle(
                    fontSize: 75,
                    color: Colors.white,
                  ))),
        ],
      ),
    );
  }

  tabla_structura_atom() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        width: 1000,
        child: Stack(
          children: [
            Image(
              image: AssetImage('assets/img/particule1.gif'),
            ),
            Positioned(
                top: 2,
                left: 80,
                child: Text(
                  titlu,
                  style: TextStyle(
                    fontSize: 34,
                    color: Colors.white,
                  ),
                )),
            Positioned(
              left: 20,
              top: 40,
              child: Text(
                'Un atom este format din 3 tipuri de',
                style: TextStyle(fontSize: 38),
              ),
            ),
            Positioned(
              left: 20,
              top: 90,
              child: Text(
                'particule subatomice fundamentale: ',
                style: TextStyle(fontSize: 38),
              ),
            ),
            Positioned(
                left: 120,
                top: 230,
                child: Text('Protoni p⁺', style: TextStyle(fontSize: 34))),
            Positioned(
                left: 120,
                top: 280,
                child: Text('Neutroni n⁰', style: TextStyle(fontSize: 34))),
            Positioned(
                left: 120,
                top: 320,
                child: Text('Electroni e⁻', style: TextStyle(fontSize: 34))),
          ],
        ));
  }
}
