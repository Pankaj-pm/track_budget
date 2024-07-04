import 'package:budget_tracker_app/db_helper.dart';
import 'package:budget_tracker_app/home/budget_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt selectedIndex = 0.obs;

  RxInt selectedCategory = 0.obs;
  RxString selectedCategoryName = "".obs;

  RxList<Map<String, Object?>> categoryList = <Map<String, Object?>>[].obs;

  TextEditingController budgetNameController = TextEditingController();
  TextEditingController budgetAmountController = TextEditingController();

  TextEditingController categoryController = TextEditingController();

  PageController pageController = PageController();

  RxBool isAdded = false.obs;

  @override
  void onInit() {
    getCategoryData();
    super.onInit();
  }

  void pageChange(int page) {
    selectedIndex.value = page;
    pageController.animateToPage(
      page,
      duration: Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  void getCategoryData() async {
    categoryList.value = await DbHelper.instance.getCategory();
  }

  Future addBudget() async {
    DbHelper.instance.addRecord(BudgetModel(
      name: budgetNameController.text,
      amount: double.tryParse(budgetAmountController.text)??0.0,
      type: selectedIndex.value ,
      category: selectedCategoryName.value,
      userId: 1,
      date: DateTime.now().toString(),
    ));
    budgetNameController.clear();
    budgetAmountController.clear();
  }
}
