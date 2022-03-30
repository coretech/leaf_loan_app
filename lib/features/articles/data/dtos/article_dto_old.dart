import 'dart:convert';

import 'package:loan_app/core/domain/entities/entities.dart';

class ArticleDtoOld {
  ArticleDtoOld({
    required this.id,
    required this.title,
    required this.description,
    required this.linkurl,
    required this.imageurl,
  });

  factory ArticleDtoOld.fromMap(Map<String, dynamic> map) {
    return ArticleDtoOld(
      id: map['_id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      linkurl: map['linkurl'] ?? '',
      imageurl: map['imageurl'] ?? '',
    );
  }

  factory ArticleDtoOld.fromJson(String source) =>
      ArticleDtoOld.fromMap(json.decode(source));

  Article toEntity() {
    return Article(
      title: title,
      description: description,
      url: linkurl,
      imageUrl: imageurl,
      id: '',
    );
  }

  final String id;
  final String title;
  final String description;
  final String linkurl;
  final String imageurl;

  ArticleDtoOld copyWith({
    String? id,
    String? title,
    String? description,
    String? linkurl,
    String? imageurl,
  }) {
    return ArticleDtoOld(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      linkurl: linkurl ?? this.linkurl,
      imageurl: imageurl ?? this.imageurl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'linkurl': linkurl,
      'imageurl': imageurl,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ArticleDtoOld(id: $id, title: $title, description: $description, '
        'linkurl: $linkurl, imageurl: $imageurl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ArticleDtoOld &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.linkurl == linkurl &&
        other.imageurl == imageurl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        linkurl.hashCode ^
        imageurl.hashCode;
  }
}
