import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../data/repository/menu_repo.dart';
import '../model/menu_model.dart';

class MenuPageController extends GetxController {
  final MenuRepo _menuRepo = MenuRepo();
  final isLoading = false.obs;
  final menuModel = MenuModel().obs;
  final selectedRestaurantIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getHomeMenu();
  }

  Future<void> getHomeMenu() async {
    try {
      isLoading.value = true;
      final response = await _menuRepo.getHomeMenu();
      if (response != null && response.statusCode == 200) {
        menuModel.value = MenuModel.fromJson(response.data);
      }
    } catch (e) {
      debugPrint('Error fetching home menu: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
