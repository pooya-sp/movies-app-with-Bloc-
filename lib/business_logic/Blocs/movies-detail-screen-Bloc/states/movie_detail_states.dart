import 'package:movies_app/data/modals/movie.dart';

abstract class MovieDetailState {
  const MovieDetailState();
}

class FavoriteMovieInitial extends MovieDetailState {}

class FavoriteMovieLoadInProgress extends MovieDetailState {}

class FavoriteMovieLoadSuccess extends MovieDetailState {
  final List<Movie> favorites;

  const FavoriteMovieLoadSuccess(
    this.favorites,
  ) : assert(
          favorites != null,
        );
}

class FavoriteMovieLoadFailure extends MovieDetailState {}

class MovieTrailerLoadInProgress extends MovieDetailState {}

class MovieTrailerLoadSuccess extends MovieDetailState {
  String url;
  MovieTrailerLoadSuccess(this.url);
}

class MovieTrailerLoadFailure extends MovieDetailState {}
