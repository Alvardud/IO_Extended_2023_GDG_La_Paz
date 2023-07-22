import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TriviasPage extends StatelessWidget {
  const TriviasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuestionarios'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('cuestionarios').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final querySnapshot = snapshot.data!;
            final queryDocumentSnapshot = querySnapshot.docs;
          }
          return const SizedBox();
        },
      ),
    );
  }
}
