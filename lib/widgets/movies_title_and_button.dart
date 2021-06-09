import 'package:flutter/material.dart';
import 'package:movies_app/locale/app_localization.dart';
import 'package:movies_app/screens/all_movies_screen.dart';

import 'package:sizer/sizer.dart';

enum MovieState {
  TOP_RATED,
  POPULAR,
  SERIES,
}

class MoviesTitleAndButton extends StatelessWidget {
  final title;
  MovieState movieState;
  MoviesTitleAndButton(this.title);
  void _instantiateMovieState() {
    switch (title) {
      case 'Top rated movies':
        movieState = MovieState.TOP_RATED;
        break;
      case 'Popular movies':
        movieState = MovieState.POPULAR;
        break;
      case 'Top rated series':
        movieState = MovieState.SERIES;
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
            // textScaleFactor:
            //     MediaQuery.of(context).textScaleFactor.clamp(1.0, 2.0),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(primary: Theme.of(context).accentColor),
          onPressed: () {
            Navigator.of(context).pushNamed(
              AllMoviesScreen.routeName,
              arguments: movieState,
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
