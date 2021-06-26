import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movies_app/UI/screens/all_movies_screen.dart';
import 'package:movies_app/UI/screens/favorite_movies_screen.dart';
import 'package:movies_app/UI/screens/language_screen.dart';
import 'package:movies_app/UI/screens/movies_detail_screen/movies_detail_screen.dart';
import 'package:movies_app/UI/screens/movies_list_screen/movies_list_screen.dart';
import 'package:movies_app/UI/screens/web_view_screen.dart';
import 'package:movies_app/business_logic/Blocs/favorite-movies-screen-Bloc/favorite_screen_bloc.dart';
import 'package:movies_app/business_logic/Blocs/movies-detail-screen-Bloc/blocs/favorite_bloc.dart';
import 'package:movies_app/business_logic/Blocs/movie-list-screen-Bloc/movies_bloc.dart';
import 'package:movies_app/UI/themes/custom_theme.dart';
import 'package:movies_app/business_logic/Blocs/movies-detail-screen-Bloc/blocs/trailer_bloc.dart';
import 'package:movies_app/helpers/config.dart';
import 'package:movies_app/data/modals/movie.dart';
import 'package:movies_app/helpers/locale/app_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sizer/sizer.dart';

List<Movie> favoritesMovies;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDocDirectory = await getApplicationDocumentsDirectory();
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
          create: (context) => FavoriteBloc(),
        ),
        BlocProvider<TrailerBloc>(
          create: (context) => TrailerBloc(),
        ),
        BlocProvider<FavoriteScreenBloc>(
          create: (context) => FavoriteScreenBloc(),
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
