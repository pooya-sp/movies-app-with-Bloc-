import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movies_app/UI/screens/all_movies_screen.dart';
import 'package:movies_app/UI/screens/favorite_movies_screen.dart';
import 'package:movies_app/UI/screens/language_screen.dart';
import 'package:movies_app/UI/screens/movies_detail_screen.dart';
import 'package:movies_app/UI/screens/movies_list_screen.dart';
import 'package:movies_app/UI/screens/web_view_screen.dart';
import 'package:movies_app/business_logic/Blocs/database_bloc.dart';
import 'package:movies_app/business_logic/Blocs/favorite_bloc.dart';
import 'package:movies_app/business_logic/Blocs/movies_bloc.dart';
import 'package:movies_app/business_logic/Blocs/trailer_bloc.dart';
import 'package:movies_app/UI/themes/custom_theme.dart';
import 'package:movies_app/helpers/config.dart';
import 'package:movies_app/data/modals/movie.dart';
import 'package:movies_app/helpers/db_helper.dart';
import 'package:movies_app/locale/app_localization.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sizer/sizer.dart';

List<Movie> favoritesMovies;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var appDocDirectory = await getApplicationDocumentsDirectory();
  DBHelper.getData('favorite_movies').then(
    (value) {
      favoritesMovies = value
          .map(
            (element) => Movie(
              posterImage: element['posterImage'],
              title: element['title'],
              overview: element['overview'],
              id: element['id'],
            ),
          )
          .toList();
    },
  );
  Hive.init(appDocDirectory.path);
  box = await Hive.openBox('hiveBox');
  String language = box.get('selectedLanguage', defaultValue: '');
  if (language.length > 0) {
    if (language.contains('fa')) {
      AppLocalization.load(Locale('fa', 'IR'));
    } else {
      AppLocalization.load(Locale('en', 'US'));
    }
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MoviesBloc>(
          create: (context) => MoviesBloc(),
        ),
        BlocProvider<FavoriteBloc>(
          create: (context) => FavoriteBloc(favoritesMovies),
        ),
        BlocProvider<DatabaseBloc>(
          create: (context) => DatabaseBloc(),
        ),
        BlocProvider<TrailerBloc>(
          create: (context) => TrailerBloc(),
        ),
      ],
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: [
            const Locale('en', 'US'),
            const Locale('fa', 'IR'),
          ],
          title: 'Movies App',
          debugShowCheckedModeBanner: false,
          theme: CustomTheme().lightTheme,
          darkTheme: CustomTheme().darkTheme,
          themeMode: currentTheme.currentTheme(),
          home: MoviesListScreen(),
          routes: {
            MoviesDetailScreen.routeName: (_) => MoviesDetailScreen(),
            WebViewScreen.routeName: (_) => WebViewScreen(),
            AllMoviesScreen.routeName: (_) => AllMoviesScreen(),
            FavoriteMoviesScreen.routeName: (_) => FavoriteMoviesScreen(),
            LanguageScreen.routeName: (_) => LanguageScreen(),
          },
        );
      }),
    );
  }
}
