import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/screens/movies_detail_screen.dart';
import 'package:movies_app/widgets/card_widget.dart';
import 'package:movies_app/widgets/movies_title_and_button.dart';
import 'package:provider/provider.dart';

// screen that is shown when user taps on All button in movies-list-screen
class AllMoviesScreen extends StatefulWidget {
  static const routeName = '/all-movies';

  @override
  _AllMoviesScreenState createState() => _AllMoviesScreenState();
}

class _AllMoviesScreenState extends State<AllMoviesScreen> {
  MoviesProvider moviesProvider;
  var _isInit = false;
  MovieState movieState;
  List<Movie> movies;
  @override
  void initState() {
    moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      movieState = ModalRoute.of(context).settings.arguments as MovieState;
      _instantiateMoviesList();
      _isInit = true;
    }
  }

  void _instantiateMoviesList() {
    switch (movieState) {
      case MovieState.TOP_RATED:
        movies = moviesProvider.topRatedMovies;
        break;
      case MovieState.POPULAR:
        movies = moviesProvider.popularMovies;
        break;
      case MovieState.SERIES:
        movies = moviesProvider.series;
        break;
    }
  }

  Widget get _appBarText {
    switch (movieState) {
      case MovieState.TOP_RATED:
        return Text('Top rated movies');
      case MovieState.POPULAR:
        return Text('Popular movies');
      case MovieState.SERIES:
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
                child: CardWidget(movies, index),
              );
            }),
      ),
    );
  }
}
