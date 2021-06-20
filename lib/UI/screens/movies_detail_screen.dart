import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/UI/widgets/movie_overview.dart';
import 'package:movies_app/UI/widgets/video_player.dart';
import 'package:movies_app/business_logic/Blocs/favorite_bloc.dart';
import 'package:movies_app/business_logic/Blocs/trailer_bloc.dart';
import 'package:movies_app/data/modals/movie.dart';

import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MoviesDetailScreen extends StatefulWidget {
  static const routeName = '/movies-detail';

  @override
  _MoviesDetailScreenState createState() => _MoviesDetailScreenState();
}

class _MoviesDetailScreenState extends State<MoviesDetailScreen> {
  // Future<String> _getVideoId(String id, context) async {
  //   final videoUrl = await Provider.of<MoviesProvider>(context, listen: false)
  //       .getMovieTrailers(int.parse(id));
  //   return YoutubePlayer.convertUrlToId(videoUrl);
  // }

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
    context.read<TrailerBloc>().add(int.parse(movieData.id));
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
            // final favoriteBloc = BlocProvider.of<FavoriteBloc>(ctx);
            BlocConsumer<FavoriteBloc, List<Movie>>(
              listener: (context, state) {
                final isFavorite = state.contains(movieData);
                _showSnackBar(movieData, isFavorite);
              },
              builder: (context, favorites) {
                return IconButton(
                  onPressed: () {
                    context.read<FavoriteBloc>().add(movieData);
                  },
                  icon: Icon(favorites.contains(movieData)
                      ? Icons.favorite
                      : Icons.favorite_border),
                );
              },
            ),
          ],
        ),
        body: ListView(
          children: [
            BlocBuilder<TrailerBloc, String>(builder: (ctx, url) {
              if (url == null) {
                return Container(
                  height: _screenHeight * 0.55,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.black),
                );
              } else {
                if (url.contains('error')) {
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
                } else {
                  final videoUrl = YoutubePlayer.convertUrlToId(url);
                  return Container(
                    height: _orientation == Orientation.landscape
                        ? _screenHeight * 0.5
                        : _screenHeight * 0.55,
                    width: double.infinity,
                    child: VideoPlayerScreen(videoUrl),
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
