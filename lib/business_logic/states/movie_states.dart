import 'package:flutter/foundation.dart';
import 'package:movies_app/data/modals/movie.dart';

abstract class MovieState {
  const MovieState();
}

class MovieInitial extends MovieState {}

class MovieLoadInProgress extends MovieState {}

class MovieLoadSuccess extends MovieState {
  final List<Movie> topRatedMovies;
  final List<Movie> popularMovies;
  final List<Movie> series;

  const MovieLoadSuccess({
    @required this.topRatedMovies,
    @required this.popularMovies,
    @required this.series,
  }) : assert(
          topRatedMovies != null && popularMovies != null && series != null,
        );
}

class MovieLoadFailure extends MovieState {}
