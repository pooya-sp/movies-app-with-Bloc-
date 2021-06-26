import 'package:movies_app/data/modals/movie.dart';

abstract class MovieDetailEvent {
  const MovieDetailEvent();
}

class FavoriteMovieRequested extends MovieDetailEvent {
  Movie movie;
  FavoriteMovieRequested(this.movie);
}

class FillFavoriteList extends MovieDetailEvent {}

class MovieTrailerRequested extends MovieDetailEvent {
  int id;
  MovieTrailerRequested(this.id);
}
