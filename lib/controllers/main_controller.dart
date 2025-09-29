import 'package:get/get.dart';

enum PageType {
  audio,
  video,
  image,
}

class MainController extends GetxController {
  final Rx<PageType> _currentPage = PageType.image.obs;
  
  PageType get currentPage => _currentPage.value;
  
  void switchToPage(PageType pageType) {
    _currentPage.value = pageType;
  }
  
  bool isCurrentPage(PageType pageType) {
    return _currentPage.value == pageType;
  }
}
