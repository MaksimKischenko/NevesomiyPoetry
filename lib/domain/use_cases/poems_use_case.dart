import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:nevesomiy/data/data.dart';
import 'package:nevesomiy/data/failure.dart';
import 'package:nevesomiy/domain/domain.dart';
import 'package:nevesomiy/domain/entites/ettities.dart';
import 'package:nevesomiy/utils/utils.dart';

class PoemsUseCase {
  final FireStoreService fireStoreService;
  final PoemsRepository poemsRepository;
  final CacheService cacheService;
  PoemsUseCase(): 
  cacheService = CacheService.instance,
  poemsRepository = PoemsRepository.instance,
  fireStoreService = FireStoreService.instance;

  Future<Either<Failure, List<Poem>>> doRemotePoems() async {
    try {
        final poems = await fireStoreService.getPoems();
        await cacheService.savePoems(poems);
        poemsRepository.addAll(poems);
        return Right(poems);  
    } on FirebaseException catch (e) {
        return Left(FireBaseFailure(error: e));
    }
  }

  Future<List<Poem>> doLocalPoems() async => cacheService.getPoems();

  List<Poem> sortPoemsByTopic(Topics value) {
    final poems = poemsRepository.poems;
    if (value != Topics.all) {
      if (value == Topics.favorite) {
        return poems.where((element) => element.isFavorite).toList();
      } else {
        return poems.where((element) => element.topicCategory == value.nameAndLocation.$1).toList();
      }
    } 
    return poems;   
  }

  Future<List<Poem>> poemMakeFavorite(Poem poem,  {required bool? isFavorite}) async{
    var poems =  await cacheService.getPoems();
    poems = poems.map<Poem>((e) {
      if(e.title == poem.title) {
       return e.copyWith(isFavorite: isFavorite);
      } else {
        return e;
      }
    }).toList();
     await cacheService.savePoems(poems);
    return poems;
  }
}