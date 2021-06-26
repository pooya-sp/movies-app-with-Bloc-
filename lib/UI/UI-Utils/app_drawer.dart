import 'package:flutter/material.dart';
import 'package:movies_app/UI/screens/favorite_movies_screen.dart';
import 'package:movies_app/UI/screens/language_screen.dart';
import 'package:movies_app/helpers/config.dart';
import 'package:movies_app/helpers/locale/app_localization.dart';

enum SelectedPage {
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
  SelectedPage selectedPage = SelectedPage.MOVIES;
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
              selected: widget.selectedPage == SelectedPage.MOVIES,
              selectedTileColor: _isDark ? Colors.red : Colors.green,
              leading: Icon(
                Icons.movie,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(AppLocalization.of(context).movies),
              onTap: () {
                setState(() {
                  widget.selectedPage = SelectedPage.MOVIES;
                });
                Navigator.of(context).pushReplacementNamed('/');
              }),
          ListTile(
              selected: widget.selectedPage == SelectedPage.FAVORITES,
              selectedTileColor: _isDark ? Colors.red : Colors.green,
              leading: Icon(
                Icons.favorite,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(AppLocalization.of(context).favoriteMovies),
              onTap: () {
                setState(() {
                  widget.selectedPage = SelectedPage.FAVORITES;
                });
                Navigator.of(context)
                    .pushReplacementNamed(FavoriteMoviesScreen.routeName);
              }),
          ListTile(
              selectedTileColor: _isDark ? Colors.red : Colors.green,
              selected: widget.selectedPage == SelectedPage.LANGUAGE,
              leading: Icon(
                Icons.language,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(AppLocalization.of(context).language),
              onTap: () {
                setState(() {
                  widget.selectedPage = SelectedPage.LANGUAGE;
                });
                Navigator.of(context)
                    .pushReplacementNamed(LanguageScreen.routeName);
              }),
        ],
      ),
    );
  }
}
