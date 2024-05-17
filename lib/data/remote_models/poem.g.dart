// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Poem _$PoemFromJson(Map<String, dynamic> json) => Poem(
      title: json['title'] as String,
      book: json['book'] as String,
      content: json['content'] as String,
      topicCategory: json['topicCategory'] as String,
      isFavorite: json['isFavorite'] as bool,
      previewContent: json['previewContent'] as String? ?? "",
      poemTopicAssetLocation: json['poemTopicAssetLocation'] as String? ?? "",
    );

Map<String, dynamic> _$PoemToJson(Poem instance) => <String, dynamic>{
      'title': instance.title,
      'book': instance.book,
      'content': instance.content,
      'isFavorite': instance.isFavorite,
      'topicCategory': instance.topicCategory,
      'previewContent': instance.previewContent,
      'poemTopicAssetLocation': instance.poemTopicAssetLocation,
    };
