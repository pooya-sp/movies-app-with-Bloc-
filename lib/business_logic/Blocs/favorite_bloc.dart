import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/modals/movie.dart';
import 'package:movies_app/helpers/db_helper.dart';

class FavoriteBloc extends Bloc<Movie, List<Movie>> {
  List<Movie> favorites;
  FavoriteBloc(this.favorites) : super(favorites);

  @override
  Stream<List<Movie>> mapEventToState(Movie movie) async* {
    List<Movie> favoriteList = List.from(favorites);
    bool isFavorite;
    if (favorites.contains(movie)) {
      favorites.remove(movie);
      favoriteList.remove(movie);
      isFavorite = false;
    } else {
      favorites.add(movie);
      favoriteList.add(movie);
      isFavorite = true;
    }
    yield favoriteList;
    DBHelper.updateData(
        'movies_table',
        {
          'posterImage': movie.posterImage,
          'title': movie.title,
          'overview': movie.overview,
          'id': movie.id,
        },
        movie.id);
    if (isFavorite) {
      DBHelper.insert(
        'favorite_movies',
        {
          'posterImage': movie.posterImage,
          'title': movie.title,
          'overview': movie.overview,
          'id': movie.id,
        },
      );
    } else {
      DBHelper.deleteRow('favorite_movies', movie.id);
    }
  }
}
