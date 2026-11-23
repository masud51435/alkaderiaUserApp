import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodnanny/app/features/home/model/home_response_model.dart'
    as home_model;
import 'package:foodnanny/config/theme/app_color.dart';
import 'package:foodnanny/widgets/add_to_cart_dialog.dart';
import 'package:foodnanny/widgets/text_widget.dart';

class MenuBookWidget extends StatefulWidget {
  const MenuBookWidget({super.key, required this.section});

  final home_model.Section section;

  @override
  State<MenuBookWidget> createState() => _MenuBookWidgetState();
}

class _MenuBookWidgetState extends State<MenuBookWidget> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<String> tabs = widget.section.tabs ?? [];
    if (tabs.isEmpty) {
      tabs = ['Restaurant', 'Express', 'Cafe'];
    }
    if (selectedTabIndex >= tabs.length) {
      selectedTabIndex = 0;
    }

    final restaurants = widget.section.restaurants ?? [];
    home_model.Restaurant? selectedRestaurant;
    if (restaurants.isNotEmpty) {
      final tabName = tabs[selectedTabIndex].toLowerCase();
      try {
        selectedRestaurant = restaurants.firstWhere(
          (r) =>
              (r.name ?? '').toLowerCase().contains(tabName) ||
              (r.slug ?? '').toLowerCase().contains(tabName),
        );
      } catch (e) {
        selectedRestaurant = selectedTabIndex < restaurants.length
            ? restaurants[selectedTabIndex]
            : restaurants.first;
      }
    }
    final items = selectedRestaurant?.items ?? [];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Eyebrow
          if (widget.section.eyebrow != null && widget.section.eyebrow!.isNotEmpty)
            TextWidget(
              text: widget.section.eyebrow!.toUpperCase(),
              color: AppColor.primaryColor,
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
            ),
          // Title
          if (widget.section.title != null && widget.section.title!.isNotEmpty)
            TextWidget(
              text: widget.section.title!,
              color: AppColor.black100,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          SizedBox(height: 16.h),

          // 3 Chips / Tabs
          SizedBox(
            height: 40.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tabs.length,
              itemBuilder: (context, index) {
                final isSelected = selectedTabIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTabIndex = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 12.w),
                    padding: EdgeInsets.symmetric(
                      horizontal: 22.w,
                      vertical: 8.h,
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
                        text: tabs[index],
                        color: isSelected ? Colors.white : AppColor.black100,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 14.h),

          // Selected Section Heading
          TextWidget(
            text: '${tabs[selectedTabIndex]} Menu',
            color: AppColor.primaryColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 14.h),

          // Horizontal Row Item List Cards
          items.isEmpty
              ? Container(
                  width: double.infinity,
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
                        text: '${tabs[selectedTabIndex]} Menu Coming Soon!',
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
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final imageUrl = item.thumb ?? item.cover ?? '';
                    final fullImageUrl = imageUrl.startsWith('http')
                        ? imageUrl
                        : 'https://hotel.w3informer.com$imageUrl';

                    final unitPrice = double.tryParse(
                            item.flatDiscountedPrice ?? item.flatPrice ?? '0') ??
                        0.0;
                    final originalPrice =
                        double.tryParse(item.flatPrice ?? '0') ?? 0.0;

                    return Container(
                      margin: EdgeInsets.only(bottom: 14.h),
                      height: 120.h,
                      decoration: BoxDecoration(
                        color: AppColor.whiteColor,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: AppColor.black40.withValues(alpha: 0.4),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Row(
                          children: [
                            // Left side: Item Image (flush to top, left, bottom)
                            Image.network(
                              fullImageUrl,
                              height: double.infinity,
                              width: 110.w,
                              fit: BoxFit.cover,
                              errorBuilder: (c, e, s) => Container(
                                height: double.infinity,
                                width: 110.w,
                                color: Colors.grey[100],
                                child: const Center(
                                  child: Icon(
                                    Icons.fastfood,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),

                            // Right side: Item Details with padding
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(10.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          text: item.name ?? '',
                                          color: AppColor.black100,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        if (item.description != null &&
                                            item.description!.isNotEmpty) ...[
                                          SizedBox(height: 2.h),
                                          TextWidget(
                                            text: item.description!,
                                            color: const Color(0xFF777777),
                                            fontSize: 11.sp,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
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
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w500,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            TextWidget(
                                              text:
                                                  item.currencyDiscountedPrice ??
                                                  item.currencyPrice ??
                                                  '',
                                              color: AppColor.black100,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            AddToCartDialog.show(
                                              context: context,
                                              id: item.id ?? 0,
                                              name: item.name ?? '',
                                              description: item.description,
                                              imageUrl:
                                                  item.thumb ?? item.cover,
                                              unitPrice: unitPrice,
                                              originalPrice:
                                                  originalPrice > unitPrice
                                                      ? originalPrice
                                                      : null,
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10.w,
                                              vertical: 5.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColor.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(14.r),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColor.primaryColor
                                                      .withValues(alpha: 0.3),
                                                  blurRadius: 6,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.add_rounded,
                                                  color: Colors.white,
                                                  size: 14.sp,
                                                ),
                                                SizedBox(width: 2.w),
                                                TextWidget(
                                                  text: 'ADD',
                                                  color: Colors.white,
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
