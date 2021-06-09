import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/screens/web_view_screen.dart';
import 'package:movies_app/widgets/video_player.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:sizer/sizer.dart';

class MoviesDetailScreen extends StatefulWidget {
  static const routeName = '/movies-detail';

  @override
  _MoviesDetailScreenState createState() => _MoviesDetailScreenState();
}

class _MoviesDetailScreenState extends State<MoviesDetailScreen> {
  int _textMaxLine = 4;
  var _isTextExpanded = false;
  Future<String> _getVideoId(String id, context) async {
    final videoUrl = await Provider.of<MoviesProvider>(context, listen: false)
        .getMovieTrailers(int.parse(id));
    return YoutubePlayer.convertUrlToId(videoUrl);
  }

  void _showSnackBar(Movie movie) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(movie.isFavorite
            ? '${movie.title} is added to favorite list'
            : '${movie.title} is removed from favorite list'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MoviesProvider>(context);
    final movieData = ModalRoute.of(context).settings.arguments as Movie;
    var placeholder = AssetImage('assets/images/placeholder.png');
    var _orientation = MediaQuery.of(context).orientation;
    var _screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(movieData);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(movieData.title),
          actions: [
            IconButton(
              onPressed: () {
                movieProvider.toggleFavorite(movieData);
                _showSnackBar(movieData);
              },
              icon: Icon(movieData.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border),
            )
          ],
        ),
        body: Column(
          children: [
            FutureBuilder<String>(
                future: _getVideoId(movieData.id, context),
                builder: (context, snapshot) {
                  try {
                    if (snapshot.hasData) {
                      return Container(
                        height: _orientation == Orientation.landscape
                            ? _screenHeight * 0.5
                            : _screenHeight * 0.6,
                        width: double.infinity,
                        child: VideoPlayerScreen(snapshot.data),
                      );
                    } else {
                      if (snapshot.hasError) {
                        return Container(
                          height: _screenHeight * 0.6,
                          width: double.infinity,
                          child: Image.network(
                            'https://image.tmdb.org/t/p/original${movieData.posterImage}',
                            fit: BoxFit.fill,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace stackTrace) {
                              return Image(image: placeholder);
                            },
                          ),
                        );
                      } else {
                        return Container(
                          height: _screenHeight * 0.6,
                          width: double.infinity,
                          decoration: BoxDecoration(color: Colors.black),
                        );
                      }
                    }
                  } catch (error) {
                    return Container(
                      height: _screenHeight * 0.6,
                      width: double.infinity,
                      child: Image.asset('assets/images/placeholder.png'),
                    );
                  }
                }),
            Container(
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
                      movieData.overview,
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
                    alignment: Alignment.topCenter,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(WebViewScreen.routeName,
                            arguments: movieData.title);
                      },
                      child: Text(
                        'See more details on imdb',
                        style: TextStyle(fontSize: 10.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
