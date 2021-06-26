import 'package:movies_app/data/modals/movie.dart';

abstract class FavoriteScreenState {
  const FavoriteScreenState();
}

class DBInitial extends FavoriteScreenState {}

class DBLoadInProgress extends FavoriteScreenState {}

class DBLoadSuccess extends FavoriteScreenState {
  final List<Movie> favorites;
  const DBLoadSuccess(
    this.favorites,
  ) : assert(
          favorites != null,
        );
}

class DBLoadFailure extends FavoriteScreenState {}
