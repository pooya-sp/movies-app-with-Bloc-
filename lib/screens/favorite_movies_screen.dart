import 'package:flutter/material.dart';
import 'package:movies_app/locale/app_localization.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/screens/movies_detail_screen.dart';
import 'package:movies_app/widgets/app_drawer.dart';
import 'package:movies_app/widgets/card_widget.dart';
import 'package:provider/provider.dart';

class FavoriteMoviesScreen extends StatefulWidget {
  static const routeName = '/favorite-movies';

  @override
  _FavoriteMoviesScreenState createState() => _FavoriteMoviesScreenState();
}

class _FavoriteMoviesScreenState extends State<FavoriteMoviesScreen> {
  List<Movie> favoriteMoviesList;
  var _isLoading = false;

  void getDataFromDB() {
    favoriteMoviesList = [];
    setState(() {
      _isLoading = true;
    });
    Provider.of<MoviesProvider>(context, listen: false)
        .getFavorites
        .then((movies) {
      favoriteMoviesList.insertAll(0, movies);
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getDataFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalization.of(context).favoriteMovies),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : favoriteMoviesList.length == 0
              ? Center(
                  child: Text(AppLocalization.of(context).noFavoriteMovies),
                )
              : _moviesGridList,
    );
  }

  Widget get _moviesGridList {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: GridView.builder(
          itemCount: favoriteMoviesList.length,
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
                Navigator.pushNamed(
                  ctx,
                  MoviesDetailScreen.routeName,
                  arguments: favoriteMoviesList[index],
                ).then((_) => getDataFromDB());
              },
              child: CardWidget(favoriteMoviesList, index),
            );
          }),
    );
  }
}
