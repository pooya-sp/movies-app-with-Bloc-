import 'package:flutter/material.dart';
import 'package:movies_app/UI/screens/all_movies_screen.dart';
import 'package:movies_app/business_logic/Blocs/movie-list-screen-Bloc/movies_bloc.dart';
import 'package:movies_app/helpers/locale/app_localization.dart';

import 'package:sizer/sizer.dart';

class MoviesTitleAndButton extends StatelessWidget {
  final title;
  MovieType movieType;
  MoviesTitleAndButton(this.title);
  void _instantiateMovieState() {
    switch (title) {
      case 'Top rated movies':
        movieType = MovieType.TOPRATED;
        break;
      case 'Popular movies':
        movieType = MovieType.POPULAR;
        break;
      case 'Top rated series':
        movieType = MovieType.SERIES;
        break;
    }
  }

  String getTitle(BuildContext context) {
    switch (title) {
      case 'Top rated movies':
        return AppLocalization.of(context).topRatedMovies;
      case 'Popular movies':
        return AppLocalization.of(context).popularMovies;
      case 'Top rated series':
        return AppLocalization.of(context).series;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    _instantiateMovieState();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Text(
            getTitle(context),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(primary: Theme.of(context).accentColor),
          onPressed: () {
            Navigator.of(context).pushNamed(
              AllMoviesScreen.routeName,
              arguments: movieType,
            );
          },
          child: Row(
            children: [
              Text(
                AppLocalization.of(context).all,
                style: TextStyle(fontSize: 13.sp),
              ),
              Icon(
                Icons.keyboard_arrow_right,
                size: 13.sp,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
