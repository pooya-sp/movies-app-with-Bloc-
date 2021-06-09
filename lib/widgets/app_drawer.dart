import 'package:flutter/material.dart';
import 'package:movies_app/locale/app_localization.dart';
import 'package:movies_app/modals/config.dart';
import 'package:movies_app/screens/favorite_movies_screen.dart';
import 'package:movies_app/screens/language_screen.dart';

enum AppDrawerState {
  MOVIES,
  FAVORITES,
  LANGUAGE,
}

class AppDrawer extends StatefulWidget {
  AppDrawer._privateConstructor();

  static final AppDrawer _instance = AppDrawer._privateConstructor();

  factory AppDrawer() {
    return _instance;
  }
  var _isMovieSelected = true;
  var _isFavoriteSelected = false;
  var _isLanguageSelected = false;
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool _isDark = currentTheme.isDark;
  // AppDrawerState appDrawerState = AppDrawerState.MOVIES;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            backgroundColor:
                _isDark ? Color.fromRGBO(41, 82, 163, 0.3) : Colors.green,
            actions: [
              IconButton(
                onPressed: () {
                  currentTheme.switchTheme();
                  setState(() {
                    _isDark = !_isDark;
                  });
                },
                icon: Icon(
                  _isDark ? Icons.light_mode : Icons.dark_mode,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
              selected: widget._isMovieSelected,
              selectedTileColor: _isDark ? Colors.red : Colors.green,
              leading: Icon(
                Icons.movie,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(AppLocalization.of(context).movies),
              onTap: () {
                setState(() {
                  widget._isMovieSelected = true;
                  widget._isFavoriteSelected = false;
                  widget._isLanguageSelected = false;
                });
                Navigator.of(context).pushReplacementNamed('/');
              }),
          ListTile(
              selected: widget._isFavoriteSelected,
              selectedTileColor: _isDark ? Colors.red : Colors.green,
              leading: Icon(
                Icons.favorite,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(AppLocalization.of(context).favoriteMovies),
              onTap: () {
                setState(() {
                  widget._isMovieSelected = false;
                  widget._isFavoriteSelected = true;
                  widget._isLanguageSelected = false;
                });
                Navigator.of(context)
                    .pushReplacementNamed(FavoriteMoviesScreen.routeName);
              }),
          ListTile(
              selectedTileColor: _isDark ? Colors.red : Colors.green,
              selected: widget._isLanguageSelected,
              leading: Icon(
                Icons.language,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(AppLocalization.of(context).language),
              onTap: () {
                setState(() {
                  widget._isMovieSelected = false;
                  widget._isFavoriteSelected = false;
                  widget._isLanguageSelected = true;
                });
                Navigator.of(context)
                    .pushReplacementNamed(LanguageScreen.routeName);
              }),
        ],
      ),
    );
  }
}
