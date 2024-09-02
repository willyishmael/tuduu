import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final FirestoreService _instance = FirestoreService._internal();

  factory FirestoreService({FirebaseFirestore? firestore}) {
    _instance.firestore = firestore ?? FirebaseFirestore.instance;
    return _instance;
  }
  
  FirestoreService._internal();

  late FirebaseFirestore firestore;

  DocumentReference getUserReference(String userId) {
    return firestore.collection('users').doc(userId);
  } 

  CollectionReference getTasksReference(String userId) {
    return getUserReference(userId).collection('tasks');
  }
}