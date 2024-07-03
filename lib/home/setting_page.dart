import 'package:budget_tracker_app/db_helper.dart';
import 'package:budget_tracker_app/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingPage extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();

  SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Add Category", style: TextStyle(fontSize: 30)),
              TextFormField(
                controller: homeController.categoryController,
                decoration: InputDecoration(hintText: "Name"),
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty) {
                    DbHelper.instance.addCategory(value, homeController.selectedCategory.value);
                    homeController.categoryController.clear();
                    Get.snackbar("Success","Category Added");
                  }
                },
              ),
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ActionChip(
                      label: Text("Income"),
                      backgroundColor: homeController.selectedCategory.value == 0 ? Colors.green : Colors.grey,
                      onPressed: () {
                        homeController.selectedCategory.value = 0;
                      },
                    ),
                    ActionChip(
                      backgroundColor: homeController.selectedCategory.value == 1 ? Colors.green : Colors.grey,
                      label: Text("Expanse"),
                      onPressed: () {
                        homeController.selectedCategory.value = 1;
                      },
                    ),
                  ],
                );
              }),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("cat name"),
                      subtitle: Text("Income"),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
