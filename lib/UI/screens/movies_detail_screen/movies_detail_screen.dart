import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/UI/screens/movies_detail_screen/movie_overview.dart';
import 'package:movies_app/UI/screens/movies_detail_screen/video_player.dart';
import 'package:movies_app/business_logic/Blocs/movies-detail-screen-Bloc/blocs/trailer_bloc.dart';
import 'package:movies_app/business_logic/Blocs/movies-detail-screen-Bloc/events/movie_detail_events.dart';
import 'package:movies_app/business_logic/Blocs/movies-detail-screen-Bloc/blocs/favorite_bloc.dart';
import 'package:movies_app/business_logic/Blocs/movies-detail-screen-Bloc/states/movie_detail_states.dart';
import 'package:movies_app/data/modals/movie.dart';

import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MoviesDetailScreen extends StatefulWidget {
  static const routeName = '/movies-detail';

  @override
  _MoviesDetailScreenState createState() => _MoviesDetailScreenState();
}

class _MoviesDetailScreenState extends State<MoviesDetailScreen> {
  void _showSnackBar(Movie movie, bool isFavorite) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: RichText(
        text: TextSpan(
            text: '${movie.title}',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
            children: [
              TextSpan(
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
                  text: isFavorite
                      ? ' is added to favorite list'
                      : ' is removed from favorite list'),
            ]),
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final movieData = ModalRoute.of(context).settings.arguments as Movie;
    context
        .read<TrailerBloc>()
        .add(MovieTrailerRequested(int.parse(movieData.id)));
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
            BlocConsumer<FavoriteBloc, MovieDetailState>(
              listener: (context, state) {
                if (state is FavoriteMovieLoadSuccess) {
                  final isFavorite = state.favorites.contains(movieData);
                  _showSnackBar(movieData, isFavorite);
                }
              },
              builder: (context, state) {
                if (state is FavoriteMovieLoadSuccess) {
                  return IconButton(
                    onPressed: () {
                      context
                          .read<FavoriteBloc>()
                          .add(FavoriteMovieRequested(movieData));
                    },
                    icon: Icon(state.favorites.contains(movieData)
                        ? Icons.favorite
                        : Icons.favorite_border),
                  );
                } else {
                  return Center();
                }
              },
            ),
          ],
        ),
        body: ListView(
          children: [
            BlocBuilder<TrailerBloc, MovieDetailState>(builder: (ctx, state) {
              if (state is MovieTrailerLoadInProgress) {
                return Container(
                  height: _screenHeight * 0.55,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.black),
                );
              } else {
                if (state is MovieTrailerLoadSuccess) {
                  final videoUrl = YoutubePlayer.convertUrlToId(state.url);
                  return Container(
                    height: _orientation == Orientation.landscape
                        ? _screenHeight * 0.5
                        : _screenHeight * 0.55,
                    width: double.infinity,
                    child: VideoPlayerScreen(videoUrl),
                  );
                } else {
                  return Container(
                    width: double.infinity,
                    height: _screenHeight * 0.55,
                    child: Image.network(
                      'https://image.tmdb.org/t/p/original${movieData.posterImage}',
                      fit: BoxFit.fill,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace stackTrace) {
                        return Image(image: placeholder);
                      },
                    ),
                  );
                }
              }
            }),
            MovieOverview(movieData),
          ],
        ),
      ),
    );
  }
}
