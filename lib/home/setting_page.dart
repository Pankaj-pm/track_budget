import 'package:budget_tracker_app/db_helper.dart';
import 'package:budget_tracker_app/generated/assets.dart';
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
                onFieldSubmitted: (value) async {
                  if (value.isNotEmpty) {
                    await DbHelper.instance.addCategory(value, homeController.selectedCategory.value);
                    homeController.categoryController.clear();
                    // homeController.getCategoryData();
                    // homeController.isAdded.refresh();
                    Get.snackbar("Success", "Category Added");
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
              // Expanded(
              //   child: Obx(() {
              //     homeController.isAdded.value;
              //     return FutureBuilder<List<Map<String, Object?>>>(
              //       future: DbHelper.instance.getCategory(),
              //       builder: (context, snapshot) {
              //         List<Map<String, Object?>> cat = snapshot.data ?? [];
              //         return RefreshIndicator(
              //           onRefresh: () async {},
              //           child: ListView.builder(
              //             itemCount: cat.length,
              //             itemBuilder: (context, index) {
              //               return ListTile(
              //                 leading: Image.asset(Assets.assetsESalon),
              //                 title: Text("cat name"),
              //                 subtitle: Text("Income"),
              //               );
              //             },
              //           ),
              //         );
              //       },
              //     );
              //   }),
              // )
              Expanded(child: Obx(() {
                return RefreshIndicator(
                  onRefresh: () async {
                    homeController.getCategoryData();
                  },
                  child: ListView.builder(
                    itemCount: homeController.categoryList.length,
                    itemBuilder: (context, index) {
                      var cat = homeController.categoryList[index];
                      var isIncome = cat["category_type"] == 0;
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: isIncome ? Colors.green : Colors.red,
                          child: Icon(
                            isIncome ? Icons.trending_up : Icons.trending_down,
                          ),
                        ),
                        title: Text("${cat["category_name"]}"),
                        subtitle: Text(isIncome ? "Income" : "Expanse"),
                      );
                    },
                  ),
                );
              }))
            ],
          ),
        ),
      ),
    );
  }
}
