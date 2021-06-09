import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/helpers/db_helper.dart';
import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String title;
  final String overview;
  final String posterImage;
  final String id;
  final String movieType;
  bool isFavorite;
  Movie({
    this.overview,
    this.posterImage,
    this.title,
    this.isFavorite = false,
    this.movieType,
    this.id,
  });
  @override
  List<Object> get props => [title, id];
}

class MoviesProvider with ChangeNotifier {
  List<Movie> _allMovies = [];

  List<Movie> get allMovies {
    return [..._allMovies];
  }

  List<Movie> get popularMovies {
    return _allMovies.where((element) {
      if (element.movieType == 'POPULAR') {
        return true;
      }
      return false;
    }).toList();
  }

  List<Movie> get series {
    return _allMovies.where((element) {
      if (element.movieType == 'SERIES') {
        return true;
      }
      return false;
    }).toList();
  }

  List<Movie> get topRatedMovies {
    return _allMovies.where((element) {
      if (element.movieType == 'TOP_RATED') {
        return true;
      }
      return false;
    }).toList();
  }

  Future<List<Movie>> get getFavorites async {
    final response = await DBHelper.getData('favorite_movies');
    List<Movie> recentSearches = response
        .map(
          (element) => Movie(
            posterImage: element['posterImage'],
            title: element['title'],
            overview: element['overview'],
            id: element['id'],
            isFavorite: element['isFavorite'] == 1 ? true : false,
          ),
        )
        .toList();
    return recentSearches;
  }

  void toggleFavorite(Movie movie) {
    bool favorite = movie.isFavorite;
    _allMovies.any((element) {
      if (element == movie) {
        element.isFavorite = !element.isFavorite;
        return true;
      }
      return false;
    });
    if (favorite == movie.isFavorite) {
      movie.isFavorite = !movie.isFavorite;
    }
    notifyListeners();
    DBHelper.updateData(
        'movies_table',
        {
          'posterImage': movie.posterImage,
          'title': movie.title,
          'overview': movie.overview,
          'id': movie.id,
          'isFavorite': movie.isFavorite ? 1 : 0,
        },
        movie.id);
    if (movie.isFavorite) {
      DBHelper.insert('favorite_movies', {
        'posterImage': movie.posterImage,
        'title': movie.title,
        'overview': movie.overview,
        'id': movie.id,
        'isFavorite': movie.isFavorite ? 1 : 0,
      });
    } else {
      DBHelper.deleteRow('favorite_movies', movie.id);
    }
  }

  Future getTopRatedMovies() async {
    List<Movie> favoriteMoviesList = [];
    DBHelper.getData('favorite_movies').then((value) {
      favoriteMoviesList.insertAll(
        0,
        value
            .map(
              (element) => Movie(
                posterImage: element['posterImage'],
                title: element['title'],
                overview: element['overview'],
                id: element['id'],
                isFavorite: element['isFavorite'] == 1 ? true : false,
              ),
            )
            .toList(),
      );
    });
    int page = 1;
    final List<Movie> loadedMovies = [];
    try {
      while (page <= 3) {
        final uri = Uri.parse(
            'https://api.themoviedb.org/3/movie/top_rated?api_key=26261a334f7e3a590b3efca0eace276a&language=en-US&page=$page');
        final response = await http.get(uri);
        if (response.statusCode >= 400) {
          throw Exception();
        }
        final extractedData =
            json.decode(response.body)['results'] as List<dynamic>;
        if (extractedData == null) {
          return null;
        }
        extractedData.forEach((value) {
          loadedMovies.add(
            Movie(
                overview: value['overview'],
                id: value['id'].toString(),
                posterImage: value['poster_path'],
                movieType: 'TOP_RATED',
                title: value['title']),
          );
        });
        page++;
      }
      favoriteMoviesList.forEach((favoriteElement) {
        loadedMovies.forEach((loadedElement) {
          if (favoriteElement == loadedElement) {
            loadedElement.isFavorite = true;
          }
        });
      });
      _allMovies.insertAll(0, loadedMovies);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future getSeries() async {
    _allMovies = [];
    List<Movie> favoriteMoviesList = [];
    DBHelper.getData('favorite_movies').then((value) {
      favoriteMoviesList.insertAll(
        0,
        value
            .map(
              (element) => Movie(
                posterImage: element['posterImage'],
                title: element['title'],
                overview: element['overview'],
                id: element['id'],
                isFavorite: element['isFavorite'] == 1 ? true : false,
              ),
            )
            .toList(),
      );
    });
    int page = 1;
    final List<Movie> loadedMovies = [];
    try {
      while (page <= 3) {
        final uri = Uri.parse(
            'https://api.themoviedb.org/3/tv/popular?api_key=26261a334f7e3a590b3efca0eace276a&language=en-US&page=$page');
        final response = await http.get(uri);
        if (response.statusCode >= 400) {
          throw Exception();
        }
        final extractedData =
            json.decode(response.body)['results'] as List<dynamic>;
        if (extractedData == null) {
          return null;
        }
        extractedData.forEach((value) {
          loadedMovies.add(
            Movie(
                overview: value['overview'],
                id: value['id'].toString(),
                posterImage: value['poster_path'],
                movieType: 'SERIES',
                title: value['name']),
          );
        });
        page++;
      }

      favoriteMoviesList.forEach((favoriteElement) {
        loadedMovies.forEach((loadedElement) {
          if (favoriteElement == loadedElement) {
            loadedElement.isFavorite = true;
          }
        });
      });
      _allMovies.insertAll(0, loadedMovies);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future getPopularMovies() async {
    List<Movie> favoriteMoviesList = [];
    DBHelper.getData('favorite_movies').then((value) {
      favoriteMoviesList.insertAll(
        0,
        value
            .map(
              (element) => Movie(
                posterImage: element['posterImage'],
                title: element['title'],
                overview: element['overview'],
                id: element['id'],
                isFavorite: element['isFavorite'] == 1 ? true : false,
              ),
            )
            .toList(),
      );
    });
    int page = 1;
    final List<Movie> loadedMovies = [];
    try {
      while (page <= 3) {
        final uri = Uri.parse(
            'https://api.themoviedb.org/3/movie/popular?api_key=26261a334f7e3a590b3efca0eace276a&language=en-US&page=$page');
        final response = await http.get(uri);
        if (response.statusCode >= 400) {
          throw Exception();
        }
        final extractedData =
            json.decode(response.body)['results'] as List<dynamic>;
        if (extractedData == null) {
          return null;
        }
        extractedData.forEach((value) {
          loadedMovies.add(
            Movie(
                overview: value['overview'],
                id: value['id'].toString(),
                posterImage: value['poster_path'],
                movieType: 'POPULAR',
                title: value['title']),
          );
        });
        page++;
      }
      favoriteMoviesList.forEach((favoriteElement) {
        loadedMovies.forEach((loadedElement) {
          if (favoriteElement == loadedElement) {
            loadedElement.isFavorite = true;
          }
        });
      });
      _allMovies.insertAll(0, loadedMovies);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<String> getMovieTrailers(int id) async {
    try {
      final uri = Uri.parse(
          'https://api.themoviedb.org/3/movie/$id/videos?api_key=26261a334f7e3a590b3efca0eace276a');
      final response = await http.get(uri);
      final extractedData =
          json.decode(response.body)['results'] as List<dynamic>;
      if (extractedData == null) {
        return null;
      }
      final key = extractedData[0]['key'];
      final anotherUri = 'https://www.youtube.com/watch?v=$key';
      return anotherUri;
    } catch (error) {
      throw error;
    }
  }
}
