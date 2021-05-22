import 'package:flutter/material.dart';

import '../../domain/entities/covid_news.dart';

class CovidNewsDisplay extends StatelessWidget {
  const CovidNewsDisplay({Key key, @required this.covidNews}) : super(key: key);
  final List<CovidNews> covidNews;

  final placeholderImage = 'images/placeholder-image.png';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
      child: ListView.builder(
        itemCount: covidNews.length,
        itemBuilder: (context, index) {
          final news = covidNews[index];
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                    child: news.urlToImage != null
                        ? Image.network(
                            news.urlToImage,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            placeholderImage,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news.title ?? 'Not available',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 17.0),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        news.description ?? 'Not available',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontSize: 15.0),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        news.author ?? 'Not available',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 15.0),
                      ),
                      const SizedBox(height: 2.5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            news.source ?? 'Not available',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(fontSize: 14.0),
                          ),
                          Text(
                            news.publishedAt.substring(0, 10) +
                                    ', ' +
                                    news.publishedAt.substring(11, 16) ??
                                'Not available',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(fontSize: 14.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
