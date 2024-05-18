import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nevesomiy/data/data.dart';
import 'package:nevesomiy/domain/domain.dart';
import 'package:nevesomiy/domain/entites/ettities.dart';

class PoemsUseCase {
  final FireStoreService fireStoreService;
  final PoemsRepository poemsRepository;
  final CacheService cacheService;
  
  PoemsUseCase._(): 
  cacheService = CacheService.instance,
  poemsRepository = PoemsRepository.instance,
  fireStoreService = FireStoreService.instance;

  static final _instance = PoemsUseCase._();
  static PoemsUseCase get instance => _instance;


  Stream<QuerySnapshot> get poemsStream => fireStoreService.poemsStream;

  List<Poem> doRemotePoemsAndListen(QuerySnapshot<Object?> data) {
    final poemTracker = data.docs.first.data() as PoemTracker;
    final poems = poemTracker.poems.reversed.toList();
    unawaited(cacheService.savePoems(poems, PrefsKeys.poemsCache));
    poemsRepository.addAll(poems);
    return poems;  
  }

  Future<List<Poem>> doLocalPoems() async {
    poemsRepository.addAll(await cacheService.getPoems(PrefsKeys.poemsCache));
    return cacheService.getPoems(PrefsKeys.poemsCache);
  }

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

  Future<List<Poem>> poemMakeFavorite(Poem poem, {required bool? isFavorite}) async{

      final contentFormatted = poem.content.trim();
      log('FORMATTED: $contentFormatted');
      final peopleLiked = poemsRepository.poems.map((e) => e.peopleLiked).toList().first;
      if(!(peopleLiked?.contains(DataManager.instance.userEmail!) ?? false) ) {
      peopleLiked?.insert(0, DataManager.instance.userEmail!);
      final newPoem = poem.copyWith(peopleLiked: peopleLiked, content: contentFormatted);
      await fireStoreService.setLikeToPoem(newPoem);
    }

    var poems = poemsRepository.poems;

    poems = poems.map<Poem>((e) {
      if(e.title == poem.title) {
       return e.copyWith(isFavorite: isFavorite);
      } else {
        return e;
      }
    }).toList();
    await cacheService.savePoems(poems, PrefsKeys.poemsCache);
    return poems;
  }

  Future<void> saveFavoritePoems() async{
    log("START");
    final containsCache = await cacheService.containsCachePoems();
    if(containsCache) {
      final cachedPoems = await cacheService.getPoems(PrefsKeys.poemsCache);
      final favoritePoems = cachedPoems.where((element) => element.isFavorite).toList();
      if(favoritePoems.isNotEmpty) {
        await cacheService.savePoems(favoritePoems, PrefsKeys.favoritePoemsCache);
        log("SAVED");
      }
    }
  }
}