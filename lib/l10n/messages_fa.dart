import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

// ignore: unnecessary_new
final messages = new MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'fa';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
        "topRatedMovies":
            MessageLookupByLibrary.simpleMessage("برترین فیلم ها"),
        "popularMovies":
            MessageLookupByLibrary.simpleMessage("محبوب ترین فیلم ها"),
        "series": MessageLookupByLibrary.simpleMessage("برترین سریال ها"),
        "all": MessageLookupByLibrary.simpleMessage("همه"),
        "movies": MessageLookupByLibrary.simpleMessage("فیلم ها "),
        "language": MessageLookupByLibrary.simpleMessage("زبان"),
        "enterKeyword":
            MessageLookupByLibrary.simpleMessage("انتخاب کلید واژه"),
        "favoriteMovies":
            MessageLookupByLibrary.simpleMessage("فیلم مورد علاقه"),
        "search": MessageLookupByLibrary.simpleMessage("جستجو"),
        "There is no favorite movies": MessageLookupByLibrary.simpleMessage(
            "هیچ فیلم مورد علاقه ای وجود ندارد"),
        "No results found":
            MessageLookupByLibrary.simpleMessage("هیج نتیجه ای یافت نشد"),
        "Clear history": MessageLookupByLibrary.simpleMessage("حذف تاریخچه"),
      };
}
