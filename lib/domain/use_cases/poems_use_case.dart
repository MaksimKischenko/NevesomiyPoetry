import 'dart:async';
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


  Future<List<Poem>> doRemotePoems() async {
    final poems = await fireStoreService.getPoems();
    poems.sort((a, b)=> (b.peopleLiked?.length ?? 0 ).compareTo(a.peopleLiked?.length ?? 0));
    await cacheService.savePoems(poems, PrefsKeys.poemsCache);
    poemsRepository.addAll(poems);
    return poems;  
  }
  
  List<Poem> doRemotePoemsAndListen(QuerySnapshot<Object?> data) {
    final poemTracker = data.docs.first.data() as PoemTracker;
    final poems = 
    poemTracker.poems
     ..sort((a, b)=> (b.peopleLiked?.length ?? 0 ).compareTo(a.peopleLiked?.length ?? 0));
    unawaited(cacheService.savePoems(poems, PrefsKeys.poemsCache));
    poemsRepository.addAll(poems);
    return poems;  
  }

  Future<List<Poem>> doLocalPoems() async {
    poemsRepository.addAll(await cacheService.getPoems(PrefsKeys.poemsCache));
    return cacheService.getPoems(PrefsKeys.poemsCache);
  }


  List<Poem> poemsSortedBy(Topics value) {
    final poems = poemsRepository.poems;
    if (value != Topics.all) {
      if (value == Topics.favorite) {
        return poems.where((element) => element.peopleLiked?.contains(DataManager.instance.userEmail) ?? false).toList();
      } else {
        return poems.where((element) => element.topicCategory == value.nameAndLocation.$1).toList();
      }
    } 
    return poems;   
  }

  Future<void> poemMakeFavorite(Poem poem) async{
      final peopleLiked = poem.peopleLiked;
      if(!(peopleLiked?.contains(DataManager.instance.userEmail!) ?? false) ) {
        peopleLiked?.insert(0, DataManager.instance.userEmail!);
        final newPoemsList = List<Poem>.from(poemsRepository.poems);
        final index = newPoemsList.indexWhere((element) => element == poem);
        if (index != -1) {
          newPoemsList[index] = poem.copyWith(peopleLiked: peopleLiked);
        }
        await fireStoreService.setLikeToPoem(newPoemsList);
    }
    final poems = poemsRepository.poems;
    await cacheService.savePoems(poems, PrefsKeys.poemsCache);
  }
}