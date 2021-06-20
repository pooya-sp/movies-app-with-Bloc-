import 'package:http/http.dart' as http;

class MovieAPI {
  Future<List<String>> fetchTopRatedMovies() async {
    int page = 1;
    List<String> jsons = [];

    try {
      while (page <= 3) {
        final uri = Uri.parse(
            'https://api.themoviedb.org/3/movie/top_rated?api_key=26261a334f7e3a590b3efca0eace276a&language=en-US&page=$page');
        final response = await http.get(uri);
        if (response.statusCode >= 400) {
          throw Exception();
        }
        jsons.add(response.body);
        page++;
      }
      return jsons;
    } catch (error) {
      throw error;
    }
  }

  Future<List<String>> fetchSeries() async {
    int page = 1;
    List<String> jsons = [];

    try {
      while (page <= 3) {
        final uri = Uri.parse(
            'https://api.themoviedb.org/3/tv/popular?api_key=26261a334f7e3a590b3efca0eace276a&language=en-US&page=$page');
        final response = await http.get(uri);
        if (response.statusCode >= 400) {
          throw Exception();
        }
        jsons.add(response.body);

        page++;
      }

      return jsons;
    } catch (error) {
      throw error;
    }
  }

  Future<List<String>> fetchPopularMovies() async {
    int page = 1;
    List<String> jsons = [];
    try {
      while (page <= 3) {
        final uri = Uri.parse(
            'https://api.themoviedb.org/3/movie/popular?api_key=26261a334f7e3a590b3efca0eace276a&language=en-US&page=$page');
        final response = await http.get(uri);
        if (response.statusCode >= 400) {
          throw Exception();
        }
        jsons.add(response.body);
        page++;
      }
      return jsons;
    } catch (error) {
      throw error;
    }
  }

  Future<String> fetchMovieTrailers(int id) async {
    try {
      final uri = Uri.parse(
          'https://api.themoviedb.org/3/movie/$id/videos?api_key=26261a334f7e3a590b3efca0eace276a');
      final response = await http.get(uri);
      return response.body;
    } catch (error) {
      throw error;
    }
  }
}
