import 'package:book_store_getx/book/model/params/get_book_list_params.dart';
import 'package:book_store_getx/book/model/response/get_book_list_response.dart';
import 'package:dio/dio.dart';

import 'package:retrofit/retrofit.dart';
part 'book_service.g.dart';

@RestApi()
abstract class BookService {
  factory BookService(Dio dio, {String baseUrl}) = _BookService;

  @GET("/")
  Future<GetBookListResponse> getBookList({
    @Queries() GetBookListParams? getBookListParams = const GetBookListParams(),
  });
}
