import 'package:budget_tracker_app/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                title: Text("Name"*10),
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.selectedIndex.value == 0) {
            print("Income");
          }else{
            print("Expanse");
          }
        },
        child: Icon(Icons.add_to_photos),
      ),
      bottomNavigationBar: Obx(() {
        return NavigationBar(
          selectedIndex: _controller.selectedIndex.value,
          onDestinationSelected: (value) {
            _controller.pageChange(value);
          },
          destinations: [
            NavigationDestination(icon: Icon(Icons.trending_up), label: "Income"),
            NavigationDestination(icon: Icon(Icons.trending_down), label: "Expanse")
          ],
        );
      }),
    );
  }
}
