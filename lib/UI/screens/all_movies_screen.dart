import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/UI/UI-Utils/card_component.dart';
import 'package:movies_app/UI/screens/movies_detail_screen/movies_detail_screen.dart';
import 'package:movies_app/business_logic/Blocs/movie-list-screen-Bloc/states/movie_states.dart';
import 'package:movies_app/business_logic/Blocs/movie-list-screen-Bloc/movies_bloc.dart';
import 'package:movies_app/data/modals/movie.dart';

// screen that is shown when user taps on All button in movies-list-screen
class AllMoviesScreen extends StatefulWidget {
  static const routeName = '/all-movies';

  @override
  _AllMoviesScreenState createState() => _AllMoviesScreenState();
}

class _AllMoviesScreenState extends State<AllMoviesScreen> {
  MovieLoadSuccess movieLoadSuccess;
  var _isInit = false;
  MovieType movieType;
  List<Movie> movies;
  @override
  void initState() {
    movieLoadSuccess = BlocProvider.of<MoviesBloc>(context, listen: false).state
        as MovieLoadSuccess;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      movieType = ModalRoute.of(context).settings.arguments as MovieType;
      _instantiateMoviesList();
      _isInit = true;
    }
  }

  void _instantiateMoviesList() {
    switch (movieType) {
      case MovieType.TOPRATED:
        movies = movieLoadSuccess.topRatedMovies;
        break;
      case MovieType.POPULAR:
        movies = movieLoadSuccess.popularMovies;
        break;
      case MovieType.SERIES:
        movies = movieLoadSuccess.series;
        break;
    }
  }

  Widget get _appBarText {
    switch (movieType) {
      case MovieType.TOPRATED:
        return Text('Top rated movies');
      case MovieType.POPULAR:
        return Text('Popular movies');
      case MovieType.SERIES:
        return Text('Top rated series');
      default:
        return Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appBarText,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width,
        child: GridView.builder(
            itemCount: movies.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 13,
              mainAxisSpacing: 15,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (ctx, index) {
              return InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  Navigator.pushNamed(ctx, MoviesDetailScreen.routeName,
                      arguments: movies[index]);
                },
                child: CardComponent(movies, index),
              );
            }),
      ),
    );
  }
}
