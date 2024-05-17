import 'dart:convert';

import 'package:nevesomiy/data/data.dart';
import 'package:nevesomiy/domain/entites/ettities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  
  CacheService._();
  static final _instance = CacheService._();
  static CacheService get instance => _instance;
  SharedPreferences? _sharedPreferences;
  
  Future<void> initialise() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }



  Future<void> _setBoolValue(String key, bool value) async =>
      await _sharedPreferences!.setBool(key, value);

  Future<void> _setStringValue(String key, String value) =>
      _sharedPreferences!.setString(key, value);

  String? _getStringValue(String key) => _sharedPreferences?.getString(key);
  
  bool? _getBoolValue(String key) => _sharedPreferences?.getBool(key);


  Future<void> saveTheme(bool isLight) async{
    await _setBoolValue('theme', isLight);
  }

  bool? getTheme() => _getBoolValue('theme');

  void savePoems(List<Poem> poems) {
    _setStringValue(CollectionData.poems.docId, json.encode(poems));
  }

  List<Poem> getPoems() => List<dynamic>.from(json.decode(_getStringValue(CollectionData.poems.docId) ?? '') as List)
        .map((jsonMap) => Poem.fromJson(Map<String, dynamic>.from(jsonMap)))
        .toList();

  void saveTopic(String name) {
    _setStringValue('topics', name);
  }

  Topics getTopic() {
    final currentTopicName = _getStringValue('topics');
    var currentTopic = Topics.all;
    if(currentTopicName != null) {
       currentTopic = Topics.values.firstWhere((topic) => topic.name == currentTopicName);
    }
    return currentTopic;
  }


  void saveLinks(Map<String, dynamic>? links) {
    _setStringValue(CollectionData.urlLinks.docId, json.encode(links));
  }

  Map<String, dynamic> getLinks() => json.decode(
    _getStringValue(CollectionData.urlLinks.docId) ?? ''
  ) as Map<String, dynamic>;

  Future<void> clearCache() async{
    await _sharedPreferences?.clear();
  }
}
