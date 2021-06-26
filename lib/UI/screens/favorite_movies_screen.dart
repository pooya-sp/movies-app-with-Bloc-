import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/UI/UI-Utils/app_drawer.dart';
import 'package:movies_app/UI/UI-Utils/card_component.dart';
import 'package:movies_app/UI/screens/movies_detail_screen/movies_detail_screen.dart';
import 'package:movies_app/business_logic/Blocs/favorite-movies-screen-Bloc/events/favorite_screen_event.dart';
import 'package:movies_app/business_logic/Blocs/favorite-movies-screen-Bloc/favorite_screen_bloc.dart';
import 'package:movies_app/business_logic/Blocs/favorite-movies-screen-Bloc/states/favorite_screen_state.dart';
import 'package:movies_app/data/modals/movie.dart';
import 'package:movies_app/helpers/locale/app_localization.dart';

import 'package:provider/provider.dart';

class FavoriteMoviesScreen extends StatelessWidget {
  static const routeName = '/favorite-movies';

  @override
  Widget build(BuildContext context) {
    context.read<FavoriteScreenBloc>().add(DBRequested());
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
      child: BlocBuilder<FavoriteScreenBloc, FavoriteScreenState>(
        builder: (context, state) {
          if (state is DBLoadInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (state is DBLoadSuccess) {
              return GridView.builder(
                itemCount: state.favorites.length,
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
                        arguments: state.favorites[index],
                      ).then(
                        (_) => context
                            .read<FavoriteScreenBloc>()
                            .add(DBRequested()),
                      );
                    },
                    child: CardComponent(state.favorites, index),
                  );
                },
              );
            } else {
              return Center(
                child: Text(
                  AppLocalization.of(context).noFavoriteMovies,
                ),
              );
            }
          }
        },
      ),
    );
  }
}
