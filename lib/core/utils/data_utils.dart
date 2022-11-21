import 'package:book_store_getx/book/model/book_model.dart';

class DataUtils {
  static String? readThumbnail(Map map, String key) =>
      map["imageLinks"]?["thumbnail"];

  static List readItems(Map map, String key) {
    return map["items"];
  }

  static List<BookModel> volumeInfoToItems(List<dynamic> volumeInfo) {
    return volumeInfo
        .map((e) => BookModel.fromJson(e["volumeInfo"] as Map<String, dynamic>))
        .toList();
  }
}
