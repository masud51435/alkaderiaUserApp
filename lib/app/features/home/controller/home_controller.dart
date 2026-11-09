import 'package:flutter/foundation.dart';
import 'package:foodnanny/app/features/home/model/home_response_model.dart' as home_model;
import 'package:foodnanny/data/repository/home_repo.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final HomeRepo _homeRepo = HomeRepo();
  final homeResponseData = home_model.HomeResponseData().obs;
  final homeLoader = false.obs;

  // Compatibility stubs for legacy widgets/screens referencing old home controller methods/properties
  final restuarantModel = Rx<dynamic>(null);
  final restaurantLoader = false.obs;
  final showCampaignLoader = false.obs;
  final campaignInfoModel = Rx<dynamic>(null);
  final restaurantList = [].obs;
  final checkSingleOfferModel = Rx<dynamic>(null);
  bool isSingleOfferAvailable = false;
  final findOfferModel = Rx<dynamic>(null);
  final bannerList = [].obs;

  Future<void> getAllRestuarantByLatLong({
    required String lat,
    required String long,
    required String deliveryOrderType,
  }) async {}

  Future<void> getSingleOfferRestaurants({
    required String lat,
    required String long,
    required String deliveryOrderType,
  }) async {}

  Future<void> getCampaignsAndOffer({
    required String lat,
    required String long,
    required String deliveryOrderType,
  }) async {}

  Future<void> showCampaign({
    required String slug,
    required String lat,
    required String long,
    required String deliveryOrderType,
  }) async {}

  Future<void> showOffer({
    required String slug,
    required String lat,
    required String long,
    required String deliveryOrderType,
  }) async {}

  Future<void> checkSingleOffer({
    required String restaurantId,
    required String lat,
    required String long,
  }) async {}

  Future<void> findOffers({
    required String lat,
    required String long,
    required String deliveryOrderType,
  }) async {}

  Future<void> getRestaurantByQuisineId({
    required String lat,
    required String long,
    required String deliveryOrderType,
    required String quisineId,
  }) async {}

  @override
  void onInit() {
    super.onInit();
    getHomeData();
  }

  Future<void> getHomeData() async {
    try {
      homeLoader.value = true;
      final response = await _homeRepo.getHomeData();
      if (response != null && response.statusCode == 200) {
        homeResponseData.value =
            home_model.HomeResponseData.fromJson(response.data);
      }
    } catch (e) {
      debugPrint('Error fetching home data: $e');
    } finally {
      homeLoader.value = false;
    }
  }
}
