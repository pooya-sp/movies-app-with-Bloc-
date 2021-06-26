import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/business_logic/Blocs/movies-detail-screen-Bloc/events/movie_detail_events.dart';
import 'package:movies_app/business_logic/Blocs/movies-detail-screen-Bloc/states/movie_detail_states.dart';
import 'package:movies_app/data/modals/movie.dart';
import 'package:movies_app/data/repositories/movie_repository.dart';
import 'package:movies_app/helpers/db_helper.dart';

class FavoriteBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  List<Movie> favorites = [];
  final MovieRepository movieRepository = MovieRepository();

  FavoriteBloc() : super(FavoriteMovieInitial());

  @override
  Stream<MovieDetailState> mapEventToState(MovieDetailEvent event) async* {
    if (event is FillFavoriteList) {
      final value = await DBHelper.getData('favorite_movies');
      favorites = value
          .map(
            (element) => Movie(
              posterImage: element['posterImage'],
              title: element['title'],
              overview: element['overview'],
              id: element['id'],
            ),
          )
          .toList();
      yield FavoriteMovieLoadSuccess(favorites);
    }
    try {
      if (event is FavoriteMovieRequested) {
        List<Movie> favoriteList = List.from(favorites);
        bool isFavorite;
        if (favorites.contains(event.movie)) {
          favorites.remove(event.movie);
          favoriteList.remove(event.movie);
          isFavorite = false;
        } else {
          favorites.add(event.movie);
          favoriteList.add(event.movie);
          isFavorite = true;
        }
        yield FavoriteMovieLoadSuccess(favorites);
        DBHelper.updateData(
            'movies_table',
            {
              'posterImage': event.movie.posterImage,
              'title': event.movie.title,
              'overview': event.movie.overview,
              'id': event.movie.id,
            },
            event.movie.id);
        if (isFavorite) {
          DBHelper.insert(
            'favorite_movies',
            {
              'posterImage': event.movie.posterImage,
              'title': event.movie.title,
              'overview': event.movie.overview,
              'id': event.movie.id,
            },
          );
        } else {
          DBHelper.deleteRow('favorite_movies', event.movie.id);
        }
      }
    } catch (error) {
      yield FavoriteMovieLoadFailure();
    }
  }
}
