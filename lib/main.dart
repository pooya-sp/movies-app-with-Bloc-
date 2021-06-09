import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movies_app/locale/app_localization.dart';
import 'package:movies_app/modals/config.dart';
import 'package:movies_app/modals/custom_theme.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/screens/all_movies_screen.dart';
import 'package:movies_app/screens/favorite_movies_screen.dart';
import 'package:movies_app/screens/language_screen.dart';
import 'package:movies_app/screens/movies_detail_screen.dart';
import 'package:movies_app/screens/movies_list_screen.dart';
import 'package:movies_app/screens/web_view_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sizer/sizer.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification.body}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var appDocDirectory = await getApplicationDocumentsDirectory();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
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

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {});
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MoviesProvider(),
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
