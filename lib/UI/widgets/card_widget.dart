import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/data/modals/movie.dart';

class CardWidget extends StatelessWidget {
  final List<Movie> movies;
  final int listIndex;
  CardWidget(this.movies, this.listIndex);
  @override
  Widget build(BuildContext context) {
    var placeholder = AssetImage('assets/images/placeholder.png');
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    'https://image.tmdb.org/t/p/w185${movies[listIndex].posterImage}',
                  ),
                  fit: BoxFit.fill,
                  onError: (exception, stackTrace) {
                    return Image(image: placeholder);
                  },
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(4),
            alignment: Alignment.center,
            child: Text(
              '${movies[listIndex].title}',
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
