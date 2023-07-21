import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ResponseFirestore {
  FirestoreType? type;
  dynamic snapshot;

  ResponseFirestore({this.snapshot, this.type});
}

mixin Firestore {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  dynamic decodeResponse(ResponseFirestore fire) {
    if (fire.type == FirestoreType.collection) {
      QuerySnapshot data = fire.snapshot as QuerySnapshot;
      return {
        'list': jsonDecode(jsonEncode(data.docs.map((e) => e.data()).toList()))
      };
    } else {
      DocumentSnapshot data = fire.snapshot as DocumentSnapshot;
      return jsonDecode(jsonEncode(data.data()));
    }
  }

  Future<ResponseFirestore> getSnapshot(String collectionId,
      {String? document}) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection(collectionId);
    if (document != null) {
      final response = await collection.doc(document).get();
      return ResponseFirestore(
          snapshot: response, type: FirestoreType.document);
    }
    final response = await collection.get();
    return ResponseFirestore(
        snapshot: response, type: FirestoreType.collection);
  }
}

enum FirestoreType { collection, document }
