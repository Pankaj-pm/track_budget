import 'package:budget_tracker_app/db_helper.dart';
import 'package:budget_tracker_app/generated/assets.dart';
import 'package:budget_tracker_app/home/budget_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  RxInt selectedIndex = 0.obs;

  RxInt selectedCategory = 0.obs;
  RxString selectedCategoryName = "".obs;
  RxString selectedCategoryPath = "".obs;
  RxString searchDate = "".obs;
  RxDouble expanseTotal = 0.0.obs;

  RxList<Map<String, Object?>> categoryList = <Map<String, Object?>>[].obs;
  RxList<Map<String, Object?>> budgetIncomeList = <Map<String, Object?>>[].obs;

  RxList<Map<String, Object?>> budgetExpanseList = <Map<String, Object?>>[].obs;
  RxList<Map<String, Object?>> budgetExpanseSearchList = <Map<String, Object?>>[].obs;

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

  TextEditingController searchController = TextEditingController();

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

    budgetExpanseSearchList.value = budgetExpanseList;
    expanseTotal.value=await DbHelper.instance.getExpanseCount();
  }

  Future deleteBudget(int id) async {
    await DbHelper.instance.deleteBudget(id);
    getBudgetData();
  }

  Future addBudget() async {
    String date = DateFormat("yyyy.MM.dd").format(DateTime.now());
    await DbHelper.instance.addRecord(BudgetModel(
      name: budgetNameController.text,
      amount: double.tryParse(budgetAmountController.text) ?? 0.0,
      type: selectedIndex.value,
      category: selectedCategoryName.value,
      categoryImg: selectedCategoryPath.value,
      userId: 1,
      date: date,
    ));
    budgetNameController.clear();
    budgetAmountController.clear();
  }

  Future updateBudget(BudgetModel model, int id) async {
    String date = DateFormat("yyyy.MM.dd").format(DateTime.now());
    await DbHelper.instance.updateRecord(
        BudgetModel(
          name: budgetNameController.text,
          amount: double.tryParse(budgetAmountController.text) ?? 0.0,
          type: selectedIndex.value,
          category: selectedCategoryName.value,
          categoryImg: selectedCategoryPath.value,
          userId: 1,
          date: date,
        ),
        id);
  }

  void searchBudgetData(String search, {String? date}) async {
    List<Map<String, Object?>> budgetExpanseList =
        await DbHelper.instance.searchExpanseBudget(data: search, date: date);
    budgetExpanseSearchList.value = budgetExpanseList;
  }
}
