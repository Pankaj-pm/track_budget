import 'package:budget_tracker_app/db_helper.dart';
import 'package:budget_tracker_app/generated/assets.dart';
import 'package:budget_tracker_app/home/budget_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt selectedIndex = 0.obs;

  RxInt selectedCategory = 0.obs;
  RxString selectedCategoryName = "".obs;
  RxString selectedCategoryPath = "".obs;

  RxList<Map<String, Object?>> categoryList = <Map<String, Object?>>[].obs;
  RxList<Map<String, Object?>> budgetIncomeList = <Map<String, Object?>>[].obs;
  RxList<Map<String, Object?>> budgetExpanseList = <Map<String, Object?>>[].obs;

  TextEditingController budgetNameController = TextEditingController();
  TextEditingController budgetAmountController = TextEditingController();

  TextEditingController categoryController = TextEditingController();

  PageController pageController = PageController();

  RxString selectCatImg = Assets.assetsEElectricity.obs;

  List catImgList = [
    Assets.assetsEElectricity,
    Assets.assetsEInternet,
    Assets.assetsEMedications,
    Assets.assetsERestaurant,
    Assets.assetsESalon,
    Assets.assetsEWater,
    Assets.assetsIGifts,
    Assets.assetsIHousing,
    Assets.assetsIMoney,
    Assets.assetsISalary,
  ];

  RxBool isAdded = false.obs;

  @override
  void onInit() {
    getCategoryData();
    getBudgetData();
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

  void getBudgetData() async {
    budgetIncomeList.value = await DbHelper.instance.getBudget(type: 0);
    budgetExpanseList.value = await DbHelper.instance.getBudget(type: 1);
  }

  Future deleteBudget(int id) async {
    await DbHelper.instance.deleteBudget(id);
    getBudgetData();
  }

  Future addBudget() async {
    await DbHelper.instance.addRecord(BudgetModel(
      name: budgetNameController.text,
      amount: double.tryParse(budgetAmountController.text) ?? 0.0,
      type: selectedIndex.value,
      category: selectedCategoryName.value,
      categoryImg: selectedCategoryPath.value,
      userId: 1,
      date: DateTime.now().toString(),
    ));
    budgetNameController.clear();
    budgetAmountController.clear();
  }

  Future updateBudget(BudgetModel model,int id) async {
    await DbHelper.instance.updateRecord(BudgetModel(
      name: budgetNameController.text,
      amount: double.tryParse(budgetAmountController.text) ?? 0.0,
      type: selectedIndex.value,
      category: selectedCategoryName.value,
      categoryImg: selectedCategoryPath.value,
      userId: 1,
      date: DateTime.now().toString(),
    ), id);
  }
}
