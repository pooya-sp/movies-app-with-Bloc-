import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/modals/movie.dart';
import 'package:movies_app/helpers/db_helper.dart';

class DatabaseBloc extends Bloc<String, List<Movie>> {
  DatabaseBloc() : super([]);

  @override
  Stream<List<Movie>> mapEventToState(String event) async* {
    List<Movie> recentSearches;
    yield recentSearches;
    final response = await DBHelper.getData(event);
    recentSearches = response
        .map(
          (element) => Movie(
            posterImage: element['posterImage'],
            title: element['title'],
            overview: element['overview'],
            id: element['id'],
          ),
        )
        .toList();
    yield recentSearches;
  }
}
