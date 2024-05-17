

import 'package:nevesomiy/domain/entites/ettities.dart';

mixin PoemParser {
  static (String, String) byTopicId(int topicId) {
    switch (topicId) {
      case 0:
        return Topics.love.nameAndLocation;
      case 1:
        return Topics.urban.nameAndLocation;
      case 2:
        return Topics.philosophy.nameAndLocation;
      case 3:
        return Topics.civil.nameAndLocation;
      case 4:
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


