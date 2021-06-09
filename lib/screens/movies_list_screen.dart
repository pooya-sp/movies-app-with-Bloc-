import 'package:flutter/material.dart';
import 'package:movies_app/modals/search_data.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/widgets/app_drawer.dart';
import 'package:movies_app/widgets/movies_list_stack.dart';
import 'package:movies_app/widgets/movies_list_view.dart';
import 'package:movies_app/widgets/movies_title_and_button.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

// first screen that is shown to users
class MoviesListScreen extends StatefulWidget {
  @override
  _MoviesListScreenState createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  var _isLoading = false;
  var _isError = false;
  ScrollController _scrollViewController;
  var _appbarColor = Colors.transparent;
  void _instantiateMovies() {
    setState(() {
      _isLoading = true;
    });
    final provider = Provider.of<MoviesProvider>(context, listen: false);
    provider.getPopularMovies().catchError((error) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    });
    provider
        .getTopRatedMovies()
        .then((_) => setState(() {
              _isLoading = false;
            }))
        .catchError((error) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    });
    provider.getSeries().catchError((error) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _instantiateMovies();
    _scrollViewController = ScrollController();
    _scrollViewController.addListener(changeColor);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollViewController.dispose();
  }

  void changeColor() {
    if ((_scrollViewController.offset <= 270.0 &&
        _appbarColor != Colors.transparent)) {
      setState(() {
        _appbarColor = Colors.transparent;
      });
    } else if ((_scrollViewController.offset > 270.0 &&
        _appbarColor != Theme.of(context).appBarTheme.color)) {
      setState(() {
        _appbarColor = Theme.of(context).appBarTheme.color;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppbar,
      drawer: _buildAppDrawer,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).accentColor,
              ),
            )
          : _isError
              ? Center(
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
                          _instantiateMovies();
                        },
                        icon: const Icon(Icons.refresh),
                        iconSize: 35.sp,
                        color: Theme.of(context).accentColor,
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  controller: _scrollViewController,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Consumer<MoviesProvider>(
                      builder: (ctx, moviesProvider, _) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MoviesListStack(moviesProvider.topRatedMovies),
                            MoviesTitleAndButton('Popular movies'),
                            MoviesListView(moviesProvider.popularMovies),
                            MoviesTitleAndButton('Top rated series'),
                            MoviesListView(moviesProvider.series),
                          ],
                        );
                      },
                    ),
                  ),
                ),
    );
  }

  Widget get _buildAppbar {
    return AppBar(
      centerTitle: true,
      backgroundColor: _appbarColor,
      elevation: 0.0,
      title: const Text('Movie App'),
      actions: [
        if (!_isLoading && !_isError)
          IconButton(
            icon: Icon(
              Icons.search,
              color: Theme.of(context).iconTheme.color,
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
