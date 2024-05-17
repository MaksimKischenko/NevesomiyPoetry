import 'dart:convert';

import 'package:nevesomiy/data/data.dart';
import 'package:nevesomiy/domain/entites/ettities.dart';


class CacheService {
  CacheService._();
  static final _instance = CacheService._();
  static CacheService get instance => _instance;

  
  Future<void> saveTheme({required bool isLightTheme}) async{
    await PreferencesHelper.write(PrefsKeys.isLightTheme, isLightTheme);
  }
  Future<bool> getTheme() async =>  await PreferencesHelper.read(PrefsKeys.isLightTheme) ?? true;


  Future<void> savePoems(List<Poem> poems) async {
    await PreferencesHelper.write(PrefsKeys.poemsCache,json.encode(poems));
  }

  Future<List<Poem>> getPoems() async=> List<dynamic>.from(json.decode(
    await PreferencesHelper.read(PrefsKeys.poemsCache) ?? '') as List)
        .map((jsonMap) => Poem.fromJson(Map<String, dynamic>.from(jsonMap)))
        .toList();

  Future<void> saveTopicName(String topicName) async{
    await PreferencesHelper.write(PrefsKeys.topicName, topicName);
  }

  Future<Topics> getTopicName() async{
    final currentTopicName = await PreferencesHelper.read(PrefsKeys.topicName);
    var currentTopic = Topics.all;
    if(currentTopicName != null) {
       currentTopic = Topics.values.firstWhere((topic) => topic.name == currentTopicName);
    }
    return currentTopic;
  }

  Future<void> clearCache() async{
    await PreferencesHelper.clear();
  }
}
