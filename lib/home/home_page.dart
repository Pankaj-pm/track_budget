import 'dart:math';

import 'package:budget_tracker_app/db_helper.dart';
import 'package:budget_tracker_app/home/budget_model.dart';
import 'package:budget_tracker_app/home/home_controller.dart';
import 'package:budget_tracker_app/home/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatelessWidget {
  final HomeController _controller = Get.put(HomeController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _controller.pageController,
          onPageChanged: (value) {
            _controller.pageChange(value);
          },
          children: [
            Obx(() {
              return RefreshIndicator(
                onRefresh: () async {
                  _controller.getBudgetData();
                },
                child: ListView.builder(
                  itemCount: _controller.budgetIncomeList.length,
                  padding: EdgeInsets.only(bottom: 70),
                  itemBuilder: (context, index) {
                    Map<String, Object?> budgetIncomeMap = _controller.budgetIncomeList[index];
                    BudgetModel budgetIncome = BudgetModel.fromJson(_controller.budgetIncomeList[index]);
                    int id = budgetIncomeMap["id"] as int;
                    return ListTile(
                      onTap: () {
                        showAddDialog(context, budget: budgetIncome, id: id);
                      },
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("${budgetIncome.categoryImg}"),
                      ),
                      title: Text("${budgetIncome.name}"),
                      subtitle: Text("${budgetIncome.category}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("${budgetIncome.amount}"),
                          IconButton(
                              onPressed: () {
                                _controller.deleteBudget(id);
                              },
                              icon: Icon(Icons.delete))
                        ],
                      ),
                    );
                  },
                ),
              );
            }),
            Obx(() {
              return ListView.builder(
                itemCount: _controller.budgetExpanseList.length,
                itemBuilder: (context, index) {
                  Map<String, Object?> budgetExpanse = _controller.budgetExpanseList[index];

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("${budgetExpanse["category_img"]}"),
                    ),
                    title: Text("${budgetExpanse["name"]}"),
                    subtitle: Text("${budgetExpanse["category"]}"),
                    trailing: Text("${budgetExpanse["amount"]}"),
                  );
                },
              );
            }),
            SettingPage()
          ],
        ),
      ),
      floatingActionButton: Obx(() {
        if (_controller.selectedIndex.value == 2) {
          return SizedBox.shrink();
        } else {
          return FloatingActionButton(
            onPressed: () {
              showAddDialog(context);
            },
            child: Icon(Icons.add_to_photos),
          );
        }
      }),
      bottomNavigationBar: Obx(() {
        return NavigationBar(
          selectedIndex: _controller.selectedIndex.value,
          animationDuration: Duration(seconds: 2),
          onDestinationSelected: (value) {
            print("value $value");
            _controller.pageChange(value);
          },
          destinations: [
            NavigationDestination(icon: Icon(Icons.trending_up), label: "Income"),
            NavigationDestination(icon: Icon(Icons.trending_down), label: "Expanse"),
            NavigationDestination(icon: Icon(Icons.settings), label: "Setting")
          ],
        );
      }),
    );
  }

  void showAddDialog(BuildContext context, {BudgetModel? budget, int? id}) {
    if (budget != null) {
      _controller.budgetNameController.text = budget.name ?? "";
      _controller.budgetAmountController.text = "${budget.amount ?? 0.0}";
    } else {
      _controller.budgetNameController.clear();
      _controller.budgetAmountController.clear();
    }

    String title="";
    String insertOrUpdate=_controller.selectedIndex.value == 0 ? "Income" : "Expanse";

    if(budget!=null){
      title="Update $insertOrUpdate";
    }else{
      title="Add $insertOrUpdate";
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                    controller: _controller.budgetNameController, decoration: InputDecoration(hintText: "Name")),
                TextFormField(
                    controller: _controller.budgetAmountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Amount")),
                DropdownMenu(
                  // initialSelection: _controller.categoryList[1],
                  // label: Text("hello"),
                  hintText: budget?.category,
                  dropdownMenuEntries: _controller.categoryList.map((element) {
                    return DropdownMenuEntry(
                        label: "${element["category_name"]}",
                        value: element,
                        leadingIcon: Image.asset(
                          "${element["category_img"]}",
                          height: 20,
                          width: 20,
                        ));
                  }).toList(),
                  onSelected: (value) {
                    _controller.selectedCategoryName.value = "${value?["category_name"]}";
                    _controller.selectedCategoryPath.value = "${value?["category_img"]}";
                    print("value $value");
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Cancel")),
            ElevatedButton(
              onPressed: () async {
                if(budget!=null){
                  await _controller.updateBudget(budget,id??0);
                }else{
                  await _controller.addBudget();
                }

                _controller.getBudgetData();
                Get.back();
              },
              child: Text("Ok"),
            )
          ],
        );
      },
    );
  }
}
