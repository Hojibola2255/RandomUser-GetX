import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/random_user_list_res.dart';
import '../services/http_service.dart';
import 'package:get/get.dart';
import '../services/log_service.dart';
import '../controllers/home_controller.dart';
import '../views/item_random_user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    _controller.loadRandomUserList();
    _controller.initScrollListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(232, 232, 232, 1),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Random User - GetX"),
        ),
        body: GetBuilder<HomeController>(
          builder: (controller) {
            return Stack(
              children: [
                ListView.builder(
                  controller: _controller.scrollController,
                  itemCount: controller.userList.length,
                  itemBuilder: (ctx, index) {
                    return itemOfRandomUser(controller.userList[index], index);
                  },
                ),
                controller.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const SizedBox.shrink(),
              ],
            );
          },
        ));
  }
}
