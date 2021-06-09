import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../l10n/messages_all.dart';

class AppLocalization {
  static Future<AppLocalization> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalization();
    });
  }

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization) ??
        AppLocalization();
  }

  // list of locales
  String get heyWorld {
    return Intl.message(
      'Hey World',
      name: 'heyWorld',
    );
  }

  String get topRatedMovies {
    return Intl.message(
      'Top rated movies',
      name: 'topRatedMovies',
    );
  }

  String get popularMovies {
    return Intl.message(
      'Popular movies',
      name: 'popularMovies',
    );
  }

  String get series {
    return Intl.message(
      'Top rated series',
      name: 'series',
    );
  }

  String get all {
    return Intl.message(
      'All',
      name: 'all',
    );
  }

  String get search {
    return Intl.message(
      'Search',
      name: 'search',
    );
  }

  String get noFavoriteMovies {
    return Intl.message(
      'There is no favorite movies',
      name: 'There is no favorite movies',
    );
  }

  String get noResultsFound {
    return Intl.message(
      'No results found',
      name: 'No results found',
    );
  }

  String get clearHistory {
    return Intl.message(
      'Clear history',
      name: 'Clear history',
    );
  }

  String get movies {
    return Intl.message(
      'movies',
      name: 'movies',
    );
  }

  String get language {
    return Intl.message(
      'Language',
      name: 'language',
    );
  }

  String get enterKeyword {
    return Intl.message(
      'Enter Keyword',
      name: 'enterKeyword',
    );
  }

  String get favoriteMovies {
    return Intl.message(
      'favorite movies',
      name: 'favoriteMovies',
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  final Locale overriddenLocale;

  const AppLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => ['en', 'fa'].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) => AppLocalization.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) => false;
}
