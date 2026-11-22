import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../widgets/loader/loader.dart';
import '../../../../widgets/text_widget.dart';
import '../controller/menu_controller.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MenuPageController menuController = Get.put(MenuPageController());

    return Scaffold(
      backgroundColor: const Color(0xFFFBF8F2),
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        elevation: 0,
        surfaceTintColor: AppColor.whiteColor,
        title: TextWidget(
          text: 'Menu',
          color: AppColor.black100,
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (menuController.isLoading.value) {
          return const Center(child: LoaderCircle());
        }

        final sections = menuController.menuModel.value.data ?? [];
        if (sections.isEmpty) {
          return Center(
            child: TextWidget(
              text: 'No menu items available',
              color: AppColor.black80,
              fontSize: 16.sp,
            ),
          );
        }

        final activeIndex = menuController.selectedRestaurantIndex.value < sections.length
            ? menuController.selectedRestaurantIndex.value
            : 0;
        final currentSection = sections[activeIndex];
        final items = currentSection.items ?? [];

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              // Horizontal Section Chips (e.g. Alkaderia Restaurant, Express, Cafe)
              SizedBox(
                height: 44.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: sections.length,
                  itemBuilder: (context, index) {
                    final isSelected = activeIndex == index;
                    return GestureDetector(
                      onTap: () {
                        menuController.selectedRestaurantIndex.value = index;
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10.w),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColor.primaryColor
                              : AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(22.r),
                          border: Border.all(
                            color: isSelected
                                ? AppColor.primaryColor
                                : AppColor.black20,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: AppColor.primaryColor.withValues(
                                      alpha: 0.2,
                                    ),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : [],
                        ),
                        child: Center(
                          child: TextWidget(
                            text: sections[index].name ?? '',
                            color: isSelected ? Colors.white : AppColor.black100,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 20.h),

              // Selected Section Title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: TextWidget(
                  text: currentSection.name ?? 'Menu',
                  color: AppColor.primaryColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 16.h),

              // Items Grid (2 Cards Side by Side) or Empty State
              items.isEmpty
                  ? Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
                      padding: EdgeInsets.symmetric(
                        vertical: 48.h,
                        horizontal: 24.w,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF7F2),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: AppColor.black20.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.restaurant_menu,
                            size: 48.sp,
                            color: AppColor.primaryColor.withValues(alpha: 0.6),
                          ),
                          SizedBox(height: 12.h),
                          TextWidget(
                            text: '${currentSection.name ?? 'Menu'} Coming Soon!',
                            color: AppColor.black100,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 6.h),
                          TextWidget(
                            text:
                                'We are preparing something special for you. Stay tuned!',
                            color: const Color(0xFF666666),
                            fontSize: 13.sp,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: items.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 12.h,
                        childAspectRatio: 0.70,
                      ),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        final imageUrl = item.thumb ?? item.cover ?? '';
                        final fullImageUrl = imageUrl.startsWith('http')
                            ? imageUrl
                            : 'https://hotel.w3informer.com$imageUrl';

                        return Container(
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: AppColor.black20.withValues(alpha: 0.4),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.03),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Item Image
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16.r),
                                ),
                                child: Image.network(
                                  fullImageUrl,
                                  height: 110.h,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (c, e, s) => Container(
                                    height: 110.h,
                                    color: Colors.grey[100],
                                    child: const Center(
                                      child: Icon(
                                        Icons.fastfood,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWidget(
                                        text: item.name ?? '',
                                        color: AppColor.black100,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (item.currencyPrice != null &&
                                              item.currencyDiscountedPrice !=
                                                  null &&
                                              item.currencyPrice !=
                                                  item.currencyDiscountedPrice)
                                            TextWidget(
                                              text: item.currencyPrice!,
                                              color: const Color(0xFF888888),
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w500,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          SizedBox(height: 2.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: TextWidget(
                                                  text:
                                                      item.currencyDiscountedPrice ??
                                                      item.currencyPrice ??
                                                      '',
                                                  color: AppColor.black100,
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.bold,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(width: 4.w),
                                              Container(
                                                height: 28.r,
                                                width: 28.r,
                                                decoration: BoxDecoration(
                                                  color: AppColor.primaryColor,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

              SizedBox(height: 80.h),
            ],
          ),
        );
      }),
    );
  }
}
