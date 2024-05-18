import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:nevesomiy/data/data.dart';
import 'package:nevesomiy/data/failure.dart';
import 'package:nevesomiy/domain/entites/ettities.dart';


class FireStoreService {
  FireStoreService._();
  static final _instance = FireStoreService._();
  static FireStoreService get instance => _instance;
  
  final _fireBase = FirebaseFirestore.instance;

  Stream<QuerySnapshot> get poemsStream =>
    FirebaseFirestore.instance
    .collection(CollectionData.poems.name)
    .withConverter(
      fromFirestore: PoemTracker.fromFirestore, 
      toFirestore: (PoemTracker poem, _) => {}
    )
    .snapshots();

  Future<List<Poem>> getPoems() async {
    final ref = await _fireBase
    .collection(CollectionData.poems.name)
    .doc(CollectionData.poemsTest.docId)
    .withConverter(
      fromFirestore: PoemTracker.fromFirestore, 
      toFirestore: (PoemTracker poem, _) => {},
    )
    .get();
    final poems = ref.data()?.poems.reversed.toList();
    return Future.value(poems);
  } 
  
  Future<void> clearData() async => await _fireBase.clearPersistence(); 

  Future<Either<Failure, DocumentSnapshot<Map<String, dynamic>>>?> getUrlLinks() async {
    try {
      final collection = await _fireBase.collection(CollectionData.urlLinks.name).doc(CollectionData.urlLinks.docId).get();

      return Right(collection);  
    } on FirebaseException catch (e) {
  
      return Left(FireBaseFailure(error: e)); 
    }
  }
} 
