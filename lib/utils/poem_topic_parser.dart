

import 'package:nevesomiy/domain/entites/ettities.dart';


mixin PoemParser {
  static (String, String) byTopicId(String topicId) {
    switch (topicId) {
      case 'О любви':
        return Topics.love.nameAndLocation;
      case 'О городах':
        return Topics.urban.nameAndLocation;
      case 'Философия':
        return Topics.philosophy.nameAndLocation;
      case 'Гражданская лирика':
        return Topics.civil.nameAndLocation;
      case 'О природе':
        return Topics.landscape.nameAndLocation;                     
     default:
        return ('', '');   
    }
  }
  
  static String byBreakContent(String content) => content.replaceAllMapped(RegExp('[А-Я]'), 
  (match) => '\n${match.group(0)}');  

  static String byPreviewContent(String content) {
    final previewContentLength = byBreakContent(content).split('\n').sublist(0, 3).join('\n').length;
    return byBreakContent(content).split('\n').sublist(0, 3).join('\n').
    replaceRange(previewContentLength - 1, previewContentLength, '...');
  }   
}


