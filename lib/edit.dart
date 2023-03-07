import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gok_project/storage/storage.dart';

const List<String> tipuriFerestre = <String>[
  'Fereastra Tip 1',
  'Fereastra Tip 2',
  'Fereastra Tip 3',
  'Fereastra Tip 4'
];

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  ScrollController _scrollController = new ScrollController();
  crudMedthods crud = new crudMedthods();
  String tipFereastra = tipuriFerestre.first;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _titluController = TextEditingController();

    final CollectionReference _lectii =
        FirebaseFirestore.instance.collection('lectii');

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              'Aici poti adauga sau edita o ${tipFereastra}',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: tipFereastra,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  tipFereastra = value!;
                });
              },
              items:
                  tipuriFerestre.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Text(
              'Editează titlu',
              style: TextStyle(fontSize: 30),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: 400,
                    child: TextField(
                      controller: _titluController,
                    ),
                  ),
                ),
                InkWell(
                  child: Text(
                    'salvează',
                    style: TextStyle(
                        backgroundColor: Colors.amberAccent,
                        fontWeight: FontWeight.w500,
                        fontSize: 22),
                  ),
                  onTap: () {
                    crud.setData({"titlu": _titluController.text}).then(
                        (result) {
                      debugPrint("setat lectia e1 l1 ca si completa");
                    }).catchError((e) {
                      print(e);
                    });
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
