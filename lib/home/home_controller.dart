import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt selectedIndex = 0.obs;

  RxInt selectedCategory = 0.obs;

  TextEditingController categoryController=TextEditingController();


  PageController pageController = PageController();

  void pageChange(int page) {
    selectedIndex.value = page;
    pageController.animateToPage(
      page,
      duration: Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }
}
