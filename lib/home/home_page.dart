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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createDatabase();
          if (_controller.selectedIndex.value == 0) {
            print("Income");
          } else {
            print("Expanse");
          }
        },
        child: Icon(Icons.add_to_photos),
      ),
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

  void createDatabase() async {
    DbHelper.instance.addRecord(BudgetModel(
      name: "Hello ${Random().nextInt(100)}",
      userId: 1,
      category: 1,
      amount: Random().nextInt(2000).toDouble(),
      type: 0,
      date: DateTime.now().toString()
    ));
  }
}
