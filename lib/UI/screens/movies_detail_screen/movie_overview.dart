import 'package:flutter/material.dart';
import 'package:movies_app/UI/screens/web_view_screen.dart';
import 'package:movies_app/data/modals/movie.dart';
import 'package:sizer/sizer.dart';

class MovieOverview extends StatefulWidget {
  final Movie movieData;
  MovieOverview(this.movieData);
  @override
  _MovieOverviewState createState() => _MovieOverviewState();
}

class _MovieOverviewState extends State<MovieOverview> {
  int _textMaxLine = 4;
  var _isTextExpanded = false;
  @override
  Widget build(BuildContext context) {
    var _orientation = MediaQuery.of(context).orientation;
    var _screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: _orientation == Orientation.landscape
          ? EdgeInsets.only(top: 16)
          : EdgeInsets.only(top: 0),
      padding: EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
      ),
      height: _orientation == Orientation.portrait
          ? _screenHeight * 0.3
          : _screenHeight * 0.3,
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 16,
              left: 4,
              right: 4,
            ),
            alignment: Alignment.center,
            child: Text(
              widget.movieData.overview,
              style: TextStyle(fontSize: 9.sp),
              overflow: TextOverflow.ellipsis,
              maxLines: _textMaxLine,
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: TextButton(
              onPressed: () {
                setState(() {
                  if (!_isTextExpanded) {
                    _textMaxLine = 20;
                    _isTextExpanded = true;
                  } else {
                    _textMaxLine = 4;
                    _isTextExpanded = false;
                  }
                });
              },
              child: Text(
                _isTextExpanded ? 'less' : 'more',
                style: TextStyle(fontSize: 9.sp),
              ),
            ),
          ),
          Container(
            height: _screenHeight * 0.05,
            alignment: Alignment.topCenter,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(WebViewScreen.routeName,
                    arguments: widget.movieData.title);
              },
              child: Text(
                'See more details on imdb',
                style: TextStyle(fontSize: 10.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
