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


  Future<List<Poem>> getPoems() async {
      final ref = await _fireBase
      .collection(CollectionData.poems.name)
      //where('age', isGreaterThan: 0)
      .doc(CollectionData.poemsTest.docId)
      .withConverter(
        fromFirestore: PoemTracker.fromFirestore, 
        toFirestore: (PoemTracker poem, _) => {},
      )
      .get();
      final poems = ref.data()?.poems;
      return Future.value(poems);
  } 
  
  


  Future<DocumentSnapshot<Map<String, dynamic>>> getPoemsCollection() async => await _fireBase
    .collection(CollectionData.poems.name)
    .doc(CollectionData.poems.docId)
    .get();

  
  

  Future<Either<Failure, DocumentSnapshot<Map<String, dynamic>>>?> getUrlLinks() async {
    try {
      final collection = await _fireBase.collection(CollectionData.urlLinks.name).doc(CollectionData.urlLinks.docId).get();

      return Right(collection);  
    } on FirebaseException catch (e) {
  
      return Left(FireBaseFailure(error: e));
       
    }
  }

  Future<void> clearData() async => await _fireBase.clearPersistence(); 
 } 
