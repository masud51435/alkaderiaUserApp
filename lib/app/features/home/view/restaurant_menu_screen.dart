import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../utils/svg_icon.dart';
import '../../../../widgets/loader/loader.dart';
import '../../../../widgets/text_widget.dart';
import '../controller/home_controller.dart';
import '../model/restaurant_menu_model.dart';

class RestaurantMenuScreen extends StatefulWidget {
  const RestaurantMenuScreen({super.key, this.endpoint});

  final String? endpoint;

  @override
  State<RestaurantMenuScreen> createState() => _RestaurantMenuScreenState();
}

class _RestaurantMenuScreenState extends State<RestaurantMenuScreen> {
  final HomeController homeController = Get.find<HomeController>();
  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    homeController.getMenuData(endpoint: widget.endpoint);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF8F2),
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        elevation: 0,
        surfaceTintColor: AppColor.whiteColor,
        leading: IconButton(
          icon: Container(
            height: 24.h,
            width: 24.w,
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              shape: BoxShape.circle,
              border: Border.all(color: AppColor.primaryColor),
            ),
            child: Padding(
              padding: EdgeInsets.all(4.r),
              child: SvgPicture.asset(
                SvgIcon.arrowLeftCircle,
                height: 24.h,
                width: 24.w,
                colorFilter: ColorFilter.mode(
                  AppColor.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          onPressed: () => Get.back(),
        ),
        title: Obx(
          () => TextWidget(
            text: homeController.restuarantMenuModel.value.data?.catalogTitle ??
                'Restaurant Menu',
            color: AppColor.black100,
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (homeController.menuRestaurantLoader.value) {
          return const Center(child: LoaderCircle());
        }

        final menuData = homeController.restuarantMenuModel.value.data;
        if (menuData == null) {
          return Center(
            child: TextWidget(
              text: 'No menu data available',
              color: AppColor.black80,
              fontSize: 16.sp,
            ),
          );
        }

        final categories = menuData.categories ?? [];
        final allItems = menuData.items ?? [];
        final allTabLabel = menuData.allItemsLabel ?? 'All';

        final bool isAllSelected = selectedCategory == 'All' ||
            selectedCategory.toLowerCase() == allTabLabel.toLowerCase();

        // Filter items by category
        List<Item> displayedItems = allItems;
        if (!isAllSelected) {
          Category? matchedCategory;
          try {
            matchedCategory = categories.firstWhere(
              (c) =>
                  (c.name ?? '').toLowerCase() ==
                  selectedCategory.toLowerCase(),
            );
          } catch (_) {
            matchedCategory = null;
          }

          if (matchedCategory != null &&
              matchedCategory.itemIds != null &&
              matchedCategory.itemIds!.isNotEmpty) {
            displayedItems = allItems
                .where((item) =>
                    item.id != null &&
                    matchedCategory!.itemIds!.contains(item.id))
                .toList();
          } else {
            displayedItems = allItems
                .where((item) =>
                    (item.categoryName ?? '').toLowerCase() ==
                    selectedCategory.toLowerCase())
                .toList();
          }
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero / Banner Header
              if (menuData.hero != null)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                  color: const Color(0xFFF9F3E8),
                  child: Column(
                    children: [
                      if (menuData.hero!.eyebrow != null)
                        TextWidget(
                          text: menuData.hero!.eyebrow!.toUpperCase(),
                          color: const Color(0xFF8C6D3B),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      SizedBox(height: 6.h),
                      if (menuData.hero!.title != null)
                        TextWidget(
                          text: menuData.hero!.title!,
                          color: AppColor.black100,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                        ),
                      SizedBox(height: 6.h),
                      if (menuData.hero!.subtitle != null)
                        TextWidget(
                          text: menuData.hero!.subtitle!,
                          color: const Color(0xFF666666),
                          fontSize: 13.sp,
                          textAlign: TextAlign.center,
                        ),
                    ],
                  ),
                ),

              SizedBox(height: 16.h),

              // Categories Section Header
              if (categories.isNotEmpty) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: TextWidget(
                    text: menuData.categoryTitle ?? 'Categories',
                    color: AppColor.primaryColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.h),

                // Categories Horizontal Scroll List
                SizedBox(
                  height: 42.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: categories.length + 1,
                    itemBuilder: (context, index) {
                      final isAllTab = index == 0;
                      final catName = isAllTab
                          ? allTabLabel
                          : (categories[index - 1].name ?? '');
                      final isSelected = isAllTab
                          ? isAllSelected
                          : (selectedCategory.toLowerCase() ==
                              catName.toLowerCase());

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = catName;
                          });
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
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: isSelected
                                  ? AppColor.primaryColor
                                  : AppColor.black20,
                            ),
                          ),
                          child: Center(
                            child: TextWidget(
                              text: catName,
                              color: isSelected
                                  ? Colors.white
                                  : AppColor.black100,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20.h),
              ],

              // Catalog Items Section Title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: TextWidget(
                  text: '$selectedCategory (${displayedItems.length})',
                  color: AppColor.black100,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12.h),

              // Items Grid (2 Cards Side by Side)
              displayedItems.isEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.h),
                      child: Center(
                        child: TextWidget(
                          text: menuData.noResultsTitle ??
                              'No menu items found in this category',
                          color: AppColor.black80,
                          fontSize: 15.sp,
                        ),
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: displayedItems.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 16.h,
                        childAspectRatio: 0.68,
                      ),
                      itemBuilder: (context, index) {
                        final item = displayedItems[index];
                        final imageUrl = item.thumb ?? item.cover ?? '';
                        final fullImageUrl = imageUrl.startsWith('http')
                            ? imageUrl
                            : 'https://alkaderia.w3informer.com$imageUrl';

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
                                  height: 120.h,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (c, e, s) => Container(
                                    height: 120.h,
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
                                  padding: EdgeInsets.all(10.w),
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
                                                  fontSize: 14.sp,
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

              SizedBox(height: 32.h),
            ],
          ),
        );
      }),
    );
  }
}
