import 'dart:convert';

import 'package:movies_app/data/dataProviders/movie_api.dart';
import 'package:movies_app/data/modals/movie.dart';

class MovieRepository {
  MovieAPI movieAPI = MovieAPI();

  Future<List<Movie>> getPopularMovies() async {
    List<Movie> loadedMovies = [];
    List<String> responses = await movieAPI.fetchPopularMovies();
    responses.forEach((element) {
      final extractedData = json.decode(element)['results'] as List<dynamic>;
      extractedData.forEach((value) {
        loadedMovies.add(Movie.fromJson(value, 'POPULAR', 'title'));
      });
    });

    return loadedMovies;
  }

  Future<List<Movie>> getTopratedMovies() async {
    List<Movie> loadedMovies = [];
    List<String> responses = await movieAPI.fetchTopRatedMovies();
    responses.forEach((element) {
      final extractedData = json.decode(element)['results'] as List<dynamic>;
      extractedData.forEach((value) {
        loadedMovies.add(
          Movie.fromJson(value, 'TOP_RATED', 'title'),
        );
      });
    });

    return loadedMovies;
  }

  Future<List<Movie>> getSeries() async {
    List<Movie> loadedMovies = [];
    List<String> responses = await movieAPI.fetchSeries();
    responses.forEach((element) {
      final extractedData = json.decode(element)['results'] as List<dynamic>;
      extractedData.forEach((value) {
        loadedMovies.add(Movie.fromJson(value, 'SERIES', 'name'));
      });
    });

    return loadedMovies;
  }

  Future<String> getMovieTrailer(int id) async {
    final response = await movieAPI.fetchMovieTrailers(id);
    final extractedData = json.decode(response)['results'] as List<dynamic>;
    if (extractedData == null) {
      return null;
    }
    final key = extractedData[0]['key'];
    final anotherUri = 'https://www.youtube.com/watch?v=$key';
    return anotherUri;
  }
}
