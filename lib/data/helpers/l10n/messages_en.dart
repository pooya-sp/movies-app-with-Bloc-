import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
        "topRatedMovies":
            MessageLookupByLibrary.simpleMessage("Top rated movies"),
        "popularMovies": MessageLookupByLibrary.simpleMessage("Popular movies"),
        "series": MessageLookupByLibrary.simpleMessage("Top rated series"),
        "all": MessageLookupByLibrary.simpleMessage("All"),
        "movies": MessageLookupByLibrary.simpleMessage("movies"),
        "language": MessageLookupByLibrary.simpleMessage("language"),
        "enterKeyword": MessageLookupByLibrary.simpleMessage("Enter Keyword"),
        "favoriteMovies":
            MessageLookupByLibrary.simpleMessage("favorite movies"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "There is no favorite movies":
            MessageLookupByLibrary.simpleMessage("There is no favorite movie"),
        "No results found":
            MessageLookupByLibrary.simpleMessage("No results found"),
        "Clear history": MessageLookupByLibrary.simpleMessage("Clear history"),
      };
}
