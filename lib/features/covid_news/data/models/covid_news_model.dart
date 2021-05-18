import 'package:covidapp/features/covid_news/domain/entities/covid_news.dart';
import 'package:flutter/foundation.dart';

class CovidNewsModel extends CovidNews {
  const CovidNewsModel({
    @required String source,
    @required String author,
    @required String title,
    @required String description,
    @required String url,
    @required String urlToImage,
    @required String publishedAt,
  }) : super(
          source: source,
          author: author,
          title: title,
          description: description,
          url: url,
          urlToImage: urlToImage,
          publishedAt: publishedAt,
        );

  factory CovidNewsModel.fromJson(Map<String, dynamic> json) {
    return CovidNewsModel(
      source: json["source"]["name"] as String,
      author: json["author"] as String,
      title: json["title"] as String,
      description: json["description"] as String,
      url: json["url"] as String,
      urlToImage: json["urlToImage"] as String,
      publishedAt: json["publishedAt"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'source': {"name": source},
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
    };
  }
}
