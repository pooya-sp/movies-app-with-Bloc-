import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/UI/screens/movies_detail_screen.dart';
import 'package:movies_app/UI/widgets/app_drawer.dart';
import 'package:movies_app/UI/widgets/card_widget.dart';
import 'package:movies_app/business_logic/Blocs/database_bloc.dart';
import 'package:movies_app/data/modals/movie.dart';
import 'package:movies_app/locale/app_localization.dart';

import 'package:provider/provider.dart';

class FavoriteMoviesScreen extends StatelessWidget {
  static const routeName = '/favorite-movies';

  @override
  Widget build(BuildContext context) {
    context.read<DatabaseBloc>().add('favorite_movies');
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalization.of(context).favoriteMovies),
      ),
      drawer: AppDrawer(),
      body: _moviesGridList(context),
    );
  }

  Widget _moviesGridList(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: BlocBuilder<DatabaseBloc, List<Movie>>(
        builder: (context, favorites) {
          if (favorites == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (favorites.isEmpty) {
              return Center(
                child: Text(
                  AppLocalization.of(context).noFavoriteMovies,
                ),
              );
            }
            return GridView.builder(
              itemCount: favorites.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 13,
                mainAxisSpacing: 15,
                childAspectRatio: 0.65,
              ),
              itemBuilder: (ctx, index) {
                return InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    Navigator.pushNamed(
                      ctx,
                      MoviesDetailScreen.routeName,
                      arguments: favorites[index],
                    ).then(
                      (_) =>
                          context.read<DatabaseBloc>().add('favorite_movies'),
                    );
                  },
                  child: CardWidget(favorites, index),
                );
              },
            );
          }
        },
      ),
    );
  }
}
