import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodnanny/app/features/address/controller/address_controller.dart';
import 'package:foodnanny/app/features/cart/controller/cart_controller.dart';
import 'package:foodnanny/app/features/home/controller/home_controller.dart';
import 'package:foodnanny/app/features/home/model/home_response_model.dart'
    as home_model;
import 'package:foodnanny/app/features/home/widgets/custom_app_bar.dart';
import 'package:foodnanny/app/features/home/widgets/dining_experiences_widget.dart';
import 'package:foodnanny/app/features/home/widgets/hero_section_widget.dart';
import 'package:foodnanny/app/features/home/widgets/menu_book_widget.dart';
import 'package:foodnanny/app/features/home/widgets/restaurant_info_widget.dart';
import 'package:foodnanny/app/features/home/widgets/signature_dishes_widget.dart';
import 'package:foodnanny/app/features/order_history/controller/order_history_controller.dart';
import 'package:foodnanny/config/theme/app_color.dart';
import 'package:foodnanny/main.dart';
import 'package:foodnanny/widgets/shimmer/home_shimmer/home_section_shimmer.dart';
import 'package:foodnanny/widgets/text_widget.dart';
import 'package:get/get.dart';
import '../widgets/active_order_status.dart';
import '../widgets/location_bottom_modal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());
  final addressController = Get.put(AddressController());
  final cartController = Get.find<CartController>();
  final orderHistoryController = Get.put(OrderHistoryController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeRefresher();
      addressController.selectedHomeAddress.value = box.read('pickAddress');
      orderHistoryController.getCurrentlyActiveOrder();
    });
  }

  homeRefresher() async {
    await Future.wait([
      addressController.getAddresses(),
      homeController.getHomeData(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
      child: Stack(
        children: [
          Scaffold(
            extendBody: true,
            backgroundColor: AppColor.whiteColor,
            appBar: CustomAppBar(
              onTap: () async {
                await locationBottomSheet(context);
              },
              pickedAddress: addressController.pickAddress,
            ),
            body: RefreshIndicator(
              color: AppColor.primaryColor,
              onRefresh: () async {
                orderHistoryController.getCurrentlyActiveOrder();
                await homeRefresher();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    Obx(() {
                      if (homeController.homeLoader.value) {
                        return const HomeSectionShimmer();
                      }
                      final rawSections = homeController
                              .homeResponseData
                              .value
                              .data
                              ?.sections ??
                          [];
                      if (rawSections.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 80.h),
                          child: Center(
                            child: TextWidget(
                              text: 'No content available',
                              color: AppColor.black80,
                              fontSize: 16.sp,
                            ),
                          ),
                        );
                      }

                      const desiredOrder = [
                        'hero',
                        'dining_experiences',
                        'signature_dishes',
                        'menu_book',
                        'about',
                        'booking',
                      ];

                      final sections = List<home_model.Section>.from(rawSections)
                        ..sort((a, b) {
                          final posA = desiredOrder.indexOf(a.id ?? '');
                          final posB = desiredOrder.indexOf(b.id ?? '');
                          return (posA == -1 ? 99 : posA)
                              .compareTo(posB == -1 ? 99 : posB);
                        });
                      final heroSection = rawSections.firstWhereOrNull((s) => s.id == 'hero');

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: sections.length,
                            itemBuilder: (context, index) {
                              return _buildSection(sections[index]);
                            },
                          ),
                          if (heroSection != null)
                            RestaurantInfoWidget(section: heroSection),
                        ],
                      );
                    }),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),
          ),
          Obx(() {
            return orderHistoryController.currentlyActiveOrder.isNotEmpty &&
                    box.read('isLoggedIn') == true
                ? Positioned(
                    bottom: 0.h,
                    left: 0.w,
                    right: 0.w,
                    child: const Material(child: ActiveOrderStatus()),
                  )
                : const SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  Widget _buildSection(home_model.Section section) {
    switch (section.id) {
      case 'hero':
        return HeroSectionWidget(section: section);
      case 'dining_experiences':
        return DiningExperiencesWidget(section: section);
      case 'signature_dishes':
        return SignatureDishesWidget(section: section);
      case 'menu_book':
        return MenuBookWidget(section: section);
      case 'about':
      case 'booking':
      case 'app_download':
        return const SizedBox.shrink();
      default:
        return const SizedBox.shrink();
    }
  }
}
