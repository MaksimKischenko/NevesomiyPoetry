

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
    // ignore: avoid_unused_constructor_parameters
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    final poemEntries = ((data?['all'] ?? []) as List<dynamic>)
    // ignore: unnecessary_lambdas
    .map((entry) => Poem.fromFirestore(entry)).toList();
    return PoemTracker(
      poems: poemEntries,
    );
  }

  Map<String, dynamic> toFirestore() => {
      'all': poems.map((poem) => poem.toFirestore()).toList(),
    };
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
  final List<String>? peopleLiked;


  const Poem({
    required this.title,
    required this.book,
    required this.content,
    required this.topicCategory,
    required this.isFavorite,
    required this.peopleLiked,
    this.previewContent = '',
    this.poemTopicAssetLocation = '',
  });

  factory Poem.fromFirestore(
    Map<String, dynamic> data,
  ) => Poem(
      title: data['title'],
      book: data['book'],
      isFavorite: false,
      content: data['content'], 
      previewContent: PoemParser.byPreviewContent(data['content']),
      topicCategory: data['topicCategory'],
      poemTopicAssetLocation: PoemParser.byTopicId(data['topicCategory']).$2,
      peopleLiked: data['peopleLiked'] is Iterable ? List.from(data['peopleLiked']) : null,
    );

    Map<String, dynamic> toFirestore() => {
      'book': book,
      'content': content,
      'title': title,
      'topicCategory': topicCategory,
      if (peopleLiked != null) 'peopleLiked': peopleLiked,
    };

  static Poem fromJson(JsonMap json) => _$PoemFromJson(json);

  JsonMap toJson() => _$PoemToJson(this);

  @override
  List<Object?> get props => [title, content, topicCategory, poemTopicAssetLocation, previewContent, isFavorite, peopleLiked];


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
    List<String>? peopleLiked,
  }) => Poem(
      title: title ?? this.title,
      book: book ?? this.book,
      content: content ?? this.content,
      isFavorite: isFavorite ?? this.isFavorite,
      topicCategory: topicCategory ?? this.topicCategory,
      previewContent: previewContent ?? this.previewContent,
      poemTopicAssetLocation: poemTopicAssetLocation ?? this.poemTopicAssetLocation,
      peopleLiked: peopleLiked ?? this.peopleLiked,
    );
}

typedef JsonMap = Map<String, dynamic>;
