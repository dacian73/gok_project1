import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class crudMedthods {
  // bool isLoggedIn() {
  //   if (FirebaseAuth.instance.currentUser() != null) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  Future<void> setData(myData) async {
    FirebaseFirestore.instance
        .collection('lectii')
        .doc('lectie')
        .update(myData)
        .catchError((e) {
      print(e);
    });
  }

  getData(String docId) async {
    // FirebaseUser user = await FirebaseAuth.instance.currentUser();

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('lectii').doc(docId);

    DocumentSnapshot documentSnapshot = await documentReference.get();

    return documentSnapshot;
  }

  updateData(selectedDoc, newValues) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(selectedDoc)
        .update(newValues)
        .catchError((e) {
      print(e);
    });
  }

  deleteData(docId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }
}
