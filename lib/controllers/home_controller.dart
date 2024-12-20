import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/random_user_list_res.dart';
import '../services/http_service.dart';
import '../services/log_service.dart';

class HomeController extends GetxController {
  bool isLoading = true;
  List<RandomUser> userList = [];

  ScrollController scrollController = ScrollController();
  int currentPage = 0;

  initScrollListener(){
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent <= scrollController.offset) {
        currentPage++;
        LogService.i(currentPage.toString());
        loadRandomUserList();
      }
    });
  }

  loadRandomUserList() async {
    isLoading = true;
    update();

    var response = await Network.GET(Network.API_RANDOM_USER_LIST, Network.paramsRandomUserList(currentPage));
    LogService.i(response!);
    var results = Network.parseRandomUserList(response).results;

    userList.addAll(results);
    isLoading = false;
    update();
  }
}
