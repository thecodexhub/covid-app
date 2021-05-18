import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class CovidNews extends Equatable {
  final String source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;

  const CovidNews({
    @required this.source,
    @required this.author,
    @required this.title,
    @required this.description,
    @required this.url,
    @required this.urlToImage,
    @required this.publishedAt,
  });

  @override
  List<Object> get props => [
        source,
        author,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
      ];

  @override
  bool get stringify => true;
}
