import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/business_logic/Blocs/movies-detail-screen-Bloc/events/movie_detail_events.dart';
import 'package:movies_app/business_logic/Blocs/movies-detail-screen-Bloc/states/movie_detail_states.dart';
import 'package:movies_app/data/repositories/movie_repository.dart';

class TrailerBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieRepository movieRepository = MovieRepository();
  TrailerBloc() : super(null);

  @override
  Stream<MovieDetailState> mapEventToState(MovieDetailEvent event) async* {
    if (event is MovieTrailerRequested) {
      try {
        yield MovieTrailerLoadInProgress();
        final url = await movieRepository.getMovieTrailer(event.id);
        yield MovieTrailerLoadSuccess(url);
      } catch (_) {
        yield MovieTrailerLoadFailure();
      }
    }
  }
}
