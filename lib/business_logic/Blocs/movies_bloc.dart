import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/business_logic/events/movie_events.dart';
import 'package:movies_app/business_logic/states/movie_states.dart';
import 'package:movies_app/data/modals/movie.dart';
import 'package:movies_app/data/repositories/movie_repository.dart';

enum MovieType {
  TOPRATED,
  POPULAR,
  SERIES,
}

class MoviesBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository = MovieRepository();
  List<Movie> allMovies = [];
  MoviesBloc() : super(MovieInitial());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    List<Movie> movies = [];
    if (event is MovieRequested) {
      yield MovieLoadInProgress();
      try {
        final topRatedMovies = await movieRepository.getTopratedMovies();
        final popularMovies = await movieRepository.getPopularMovies();
        final series = await movieRepository.getSeries();
        yield MovieLoadSuccess(
          topRatedMovies: topRatedMovies,
          popularMovies: popularMovies,
          series: series,
        );
        movies.insertAll(0, topRatedMovies);
        movies.insertAll(0, popularMovies);
        movies.insertAll(0, series);
        allMovies = movies;
      } catch (_) {
        yield MovieLoadFailure();
      }
    }
  }
}
