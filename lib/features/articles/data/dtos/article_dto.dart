import 'dart:convert';

import 'package:loan_app/core/domain/entities/entities.dart';

class ArticleDto {
  ArticleDto({
    required this.id,
    required this.title,
    required this.description,
    required this.linkUrl,
    required this.imageUrl,
    required this.createdAt,
  });

  factory ArticleDto.fromMap(Map<String, dynamic> map) {
    return ArticleDto(
      id: map['id'] ,
      title: map['title'] ,
      description: map['description'] ,
      linkUrl: map['linkUrl'] ,
      imageUrl: map['imageUrl'] ,
      createdAt: map['createdAt'] ,
    );
  }

  factory ArticleDto.fromJson(String source) =>
      ArticleDto.fromMap(json.decode(source));

  final String id;
  final String title;
  final String description;
  final String linkUrl;
  final String imageUrl;
  final String createdAt;

  Article toEntity() {
    return Article(
      title: title,
      description: description,
      url: linkUrl,
      imageUrl: imageUrl,
      id: id,
    );
  }

  ArticleDto copyWith({
    String? id,
    String? title,
    String? description,
    String? linkUrl,
    String? imageUrl,
    String? createdAt,
  }) {
    return ArticleDto(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      linkUrl: linkUrl ?? this.linkUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'linkUrl': linkUrl,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ArticleDto(id: $id, title: $title, description: '
        '$description, linkUrl: $linkUrl, imageUrl: $imageUrl, '
        'createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ArticleDto &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.linkUrl == linkUrl &&
        other.imageUrl == imageUrl &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        linkUrl.hashCode ^
        imageUrl.hashCode ^
        createdAt.hashCode;
  }
}
