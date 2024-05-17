
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nevesomiy/utils/utils.dart';

part 'poem.g.dart';

class PoemTracker {
  final List<Poem> poems;

  PoemTracker({
    required this.poems,
  });

  factory PoemTracker.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    final poemEntries = ((data?['all'] ?? []) as List<dynamic>)
    .map((entry) => Poem.fromFirestore(entry)).toList();
    return PoemTracker(
      poems: poemEntries,
    );
  }
}

@immutable
@JsonSerializable()
class Poem extends Equatable {
  final String title;
  final String book;
  final String content;
  final bool isFavorite;
  final String topicCategory;
  final String previewContent;
  final String poemTopicAssetLocation;


  const Poem({
    required this.title,
    required this.book,
    required this.content,
    required this.topicCategory,
    required this.isFavorite,
    this.previewContent = '',
    this.poemTopicAssetLocation = '',
  });

  factory Poem.fromFirestore(
    Map<String, dynamic> data,
  ) => Poem(
      title: data['title'],
      book: data['book'],
      isFavorite: data['isFavorite'],
      content: PoemParser.byBreakContent(data['content']),
      previewContent: PoemParser.byPreviewContent(data['content']),
      topicCategory: PoemParser.byTopicId(data['topicCategory']).$1,
      poemTopicAssetLocation: PoemParser.byTopicId(data['topicCategory']).$2
    );

    Map<String, dynamic> toFirestore() => {
      'isFavorite': isFavorite,
    };
  static Poem fromJson(JsonMap json) => _$PoemFromJson(json);

  JsonMap toJson() => _$PoemToJson(this);

  @override
  List<Object?> get props => [title, content, topicCategory, poemTopicAssetLocation, previewContent, isFavorite];


  @override
  bool get stringify => true;

  Poem copyWith({
    String? title,
    String? book,
    String? content,
    bool? isFavorite,
    String? topicCategory,
    String? previewContent,
    String? poemTopicAssetLocation,
  }) => Poem(
      title: title ?? this.title,
      book: book ?? this.book,
      content: content ?? this.content,
      isFavorite: isFavorite ?? this.isFavorite,
      topicCategory: topicCategory ?? this.topicCategory,
      previewContent: previewContent ?? this.previewContent,
      poemTopicAssetLocation: poemTopicAssetLocation ?? this.poemTopicAssetLocation,
    );
}

typedef JsonMap = Map<String, dynamic>;
