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
      body: PageView(
        controller: _controller.pageController,
        onPageChanged: (value) {
          _controller.pageChange(value);
        },
        children: [
          ListView.builder(
            itemCount: 20,
            padding: EdgeInsets.only(bottom: 70),
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.wallet),
                ),
                title: Text("Name" * 10),
                subtitle: Text("Category"),
                trailing: Text("120"),
              );
            },
          ),
          Container(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.wallet),
                  ),
                  title: Text("Name"),
                  subtitle: Text("Category"),
                  trailing: Text("120"),
                );
              },
            ),
          ),
          SettingPage()
        ],
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
            _controller.pageChange(value);
          },
          destinations: [
            NavigationDestination(icon: Icon(Icons.trending_up), label: "Income"),
            NavigationDestination(icon: Icon(Icons.trending_down), label: "Expanse"),
            NavigationDestination(icon: Icon(Icons.settings), label: "Expanse")
          ],
        );
      }),
    );
  }

  void showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Income"),
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
                  dropdownMenuEntries: _controller.categoryList.map((element) {
                    return DropdownMenuEntry(
                      label: "${element["category_name"]}",
                      value: "${element["category_name"]}",
                    );
                  }).toList(),
                  onSelected: (value) {
                    _controller.selectedCategoryName.value = value ?? "";
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
              onPressed: () {
                _controller.addBudget();
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
