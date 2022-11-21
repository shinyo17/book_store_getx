import 'package:book_store_getx/book/controller/book_controller.dart';
import 'package:book_store_getx/book/model/book_model.dart';
import 'package:book_store_getx/core/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BookHomePage extends StatelessWidget {
  BookHomePage({Key? key}) : super(key: key);

  final BookController bookCtrl = Get.put(BookController());

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: _AppBar(),
      child: Obx(() {
        if (bookCtrl.books.isEmpty) {
          return const _WhenListIsEmpty();
        }
        return _BookListView();
      }),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  _AppBar({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  final BookController bookCtrl = Get.find<BookController>();

  /// 검색 함수
  /// 엔터를 누르거나 돋보기 아이콘을 누를 때 호출
  void search() {
    String keyword = searchController.text;
    if (keyword.isNotEmpty) {
      bookCtrl.getBooks(keyword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: false,
      title: Text(
        "Book Store",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      actions: [
        Obx(() {
          return Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(right: 12),
            child: Text(
              "total ${bookCtrl.books.length}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          );
        }),
      ],

      /// AppBar의 Bottom은 항상 PreferredSize 위젯으로 시작해야합니다.
      bottom: PreferredSize(
        preferredSize: Size(double.infinity, 72),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: "원하시는 책을 검색해주세요.",
              // 테두리
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),

              /// 돋보기 아이콘
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // 돋보기 아이콘 클릭
                  search();
                },
              ),
            ),
            onSubmitted: (v) {
              // 엔터를 누르는 경우
              search();
            },
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 72);
}

class _WhenListIsEmpty extends StatelessWidget {
  const _WhenListIsEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "검색어를 입력해 주세요",
        style: TextStyle(
          fontSize: 21,
          color: Colors.grey,
        ),
      ),
    );
  }
}

class _BookListView extends StatelessWidget {
  _BookListView({Key? key}) : super(key: key);

  final BookController bookCtrl = Get.find<BookController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        itemCount: bookCtrl.books.length,
        itemBuilder: (context, index) {
          BookModel book = bookCtrl.books[index];
          return _BookWidget(book: book);
        },
      );
    });
  }
}

class _BookWidget extends StatelessWidget {
  const _BookWidget({
    Key? key,
    required this.book,
  }) : super(key: key);

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        book.thumbnail,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
      ),
      title: Text(book.title),
      subtitle: Text(book.subtitle),
      onTap: () {
        launchUrlString(book.previewLink);
      },
    );
  }
}
