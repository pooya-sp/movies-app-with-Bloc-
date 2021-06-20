import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String title;
  final String overview;
  final String posterImage;
  final String id;
  final String movieType;
  Movie({
    this.overview,
    this.posterImage,
    this.title,
    this.movieType,
    this.id,
  });
  @override
  List<Object> get props => [title, id];

  Movie.fromJson(json, String movieType, String title)
      : title = json[title],
        overview = json['overview'],
        id = json['id'].toString(),
        posterImage = json['poster_path'],
        movieType = movieType;
}
