import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodnanny/app/features/home/model/home_response_model.dart'
    as home_model;
import 'package:foodnanny/config/theme/app_color.dart';
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
          if (widget.section.eyebrow != null)
            TextWidget(
              text: widget.section.eyebrow!.toUpperCase(),
              color: AppColor.primaryColor,
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
            ),
          SizedBox(height: 6.h),
          // Title
          if (widget.section.title != null)
            TextWidget(
              text: widget.section.title!,
              color: AppColor.black100,
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
            ),
          SizedBox(height: 6.h),
          // Subtitle
          if (widget.section.subtitle != null)
            TextWidget(
              text: widget.section.subtitle!,
              color: const Color(0xFF666666),
              fontSize: 14.sp,
            ),
          SizedBox(height: 16.h),

          // 3 Chips / Tabs
          SizedBox(
            height: 44.h,
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
                      horizontal: 24.w,
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
                        text: tabs[index],
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
          SizedBox(height: 24.h),

          // Selected Section Heading
          TextWidget(
            text: '${tabs[selectedTabIndex]} Menu',
            color: AppColor.primaryColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 16.h),

          // Items GridView (2 cards side by side) or Empty State ("Coming Soon")
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
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.h,
                    childAspectRatio: 0.72,
                  ),
                  itemBuilder: (context, index) {
                    final item = items[index];
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWidget(
                                        text:
                                            item.currencyDiscountedPrice ??
                                            item.currencyPrice ??
                                            '',
                                        color: AppColor.primaryColor,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
