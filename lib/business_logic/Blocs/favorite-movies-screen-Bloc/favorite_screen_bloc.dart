import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/business_logic/Blocs/favorite-movies-screen-Bloc/events/favorite_screen_event.dart';
import 'package:movies_app/business_logic/Blocs/favorite-movies-screen-Bloc/states/favorite_screen_state.dart';
import 'package:movies_app/data/modals/movie.dart';
import 'package:movies_app/helpers/db_helper.dart';

class FavoriteScreenBloc
    extends Bloc<FavoriteScreenEvent, FavoriteScreenState> {
  FavoriteScreenBloc() : super(DBInitial());

  @override
  Stream<FavoriteScreenState> mapEventToState(
      FavoriteScreenEvent event) async* {
    try {
      if (event is DBRequested) {
        yield DBLoadInProgress();
        List<Movie> favorites;
        final response = await DBHelper.getData('favorite_movies');
        favorites = response
            .map(
              (element) => Movie(
                posterImage: element['posterImage'],
                title: element['title'],
                overview: element['overview'],
                id: element['id'],
              ),
            )
            .toList();
        yield DBLoadSuccess(favorites);
      }
    } catch (_) {
      yield DBLoadFailure();
    }
  }
}
