import 'package:book_store_getx/book/model/book_model.dart';
import 'package:book_store_getx/book/model/params/get_book_list_params.dart';
import 'package:book_store_getx/book/model/response/get_book_list_response.dart';
import 'package:book_store_getx/book/service/book_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class BookController extends GetxController {
  BookService bookService = BookService(Dio(),
      baseUrl: "https://www.googleapis.com/books/v1/volumes");

  RxList<BookModel> books = <BookModel>[].obs;

  void getBooks(String q) async {
    books.clear();

    GetBookListParams params =
        GetBookListParams(q: q, startIndex: 0, maxResults: 40);
    GetBookListResponse res =
        await bookService.getBookList(getBookListParams: params);
    List<BookModel> items = res.items;

    books.value = items;
  }
}
