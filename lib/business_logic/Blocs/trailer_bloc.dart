import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/repositories/movie_repository.dart';

class TrailerBloc extends Bloc<int, String> {
  final MovieRepository movieRepository = MovieRepository();
  TrailerBloc() : super(null);

  @override
  Stream<String> mapEventToState(int event) async* {
    try {
      yield null;
      final url = await movieRepository.getMovieTrailer(event);
      yield url;
    } catch (error) {
      yield 'error';
    }
  }
}
