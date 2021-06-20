import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:movies_app/UI/widgets/app_drawer.dart';
import 'package:movies_app/UI/widgets/movies_list_stack.dart';
import 'package:movies_app/UI/widgets/movies_list_view.dart';
import 'package:movies_app/UI/widgets/movies_title_and_button.dart';
import 'package:movies_app/business_logic/Blocs/movies_bloc.dart';
import 'package:movies_app/business_logic/events/movie_events.dart';
import 'package:movies_app/business_logic/states/movie_states.dart';
import 'package:movies_app/UI/screens/search_movies_screen.dart';

import 'package:sizer/sizer.dart';

// first screen that is shown to users
class MoviesListScreen extends StatefulWidget {
  @override
  _MoviesListScreenState createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  var _isLoading = false;
  var _isError = false;

  @override
  void initState() {
    super.initState();
    context.read<MoviesBloc>().add(MovieRequested());
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppbar,
      drawer: _buildAppDrawer,
      body: BlocBuilder<MoviesBloc, MovieState>(builder: (ctx, state) {
        if (state is MovieLoadInProgress) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).accentColor,
            ),
          );
        }
        if (state is MovieLoadSuccess) {
          final popularMovies = state.popularMovies;
          final topRatedMovies = state.topRatedMovies;
          final series = state.series;
          return SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MoviesListStack(topRatedMovies),
                  MoviesTitleAndButton('Popular movies'),
                  MoviesListView(popularMovies),
                  MoviesTitleAndButton('Top rated series'),
                  MoviesListView(series),
                ],
              ),
            ),
          );
        }
        if (state is MovieLoadFailure) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: Text(
                    'Something went wrong. please try again',
                    style: TextStyle(fontSize: 13.sp),
                  ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                IconButton(
                  onPressed: () {
                    context.read<MoviesBloc>().add(MovieRequested());
                  },
                  icon: const Icon(Icons.refresh),
                  iconSize: 35.sp,
                  color: Theme.of(context).accentColor,
                ),
              ],
            ),
          );
        }
        return Center();
      }),
    );
  }

  Widget get _buildAppbar {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.black26,
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0.0,
      title: const Text(
        'Movie App',
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        if (!_isLoading && !_isError)
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () => showSearch(
              context: context,
              delegate: SearchData(context),
            ),
          ),
      ],
    );
  }

  Widget get _buildAppDrawer {
    if (!_isLoading || _isError) {
      return AppDrawer();
    } else {
      return null;
    }
  }
}
