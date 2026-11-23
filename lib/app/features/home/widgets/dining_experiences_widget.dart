import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodnanny/app/features/home/model/home_response_model.dart'
    as home_model;
import 'package:foodnanny/app/features/home/view/restaurant_menu_screen.dart';
import 'package:foodnanny/config/theme/app_color.dart';
import 'package:foodnanny/utils/api_list.dart';
import 'package:foodnanny/widgets/text_widget.dart';
import 'package:get/get.dart';

class DiningExperiencesWidget extends StatelessWidget {
  const DiningExperiencesWidget({super.key, required this.section});

  final home_model.Section section;

  IconData _getIconForCard(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('cafe')) {
      return Icons.local_cafe_rounded;
    } else if (lower.contains('express')) {
      return Icons.electric_bolt_rounded;
    } else {
      return Icons.restaurant_rounded;
    }
  }

  String _getEndpointForCard(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('cafe')) {
      return ApiList.menuCafe;
    } else if (lower.contains('express')) {
      return ApiList.menuExpress;
    } else {
      return ApiList.menuRestaurant;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cards = section.cards ?? [];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (section.eyebrow != null && section.eyebrow!.isNotEmpty)
            TextWidget(
              text: section.eyebrow!.toUpperCase(),
              color: AppColor.primaryColor,
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
            ),
          if (section.eyebrow != null && section.eyebrow!.isNotEmpty)

          if (section.title != null && section.title!.isNotEmpty)
            TextWidget(
              text: section.title!,
              color: AppColor.black100,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          if (section.title != null && section.title!.isNotEmpty)
            SizedBox(height: 12.h),

          // 3 Foodpanda Style Category Cards Side-by-Side
          Row(
            children: (cards.isEmpty
                    ? [
                        home_model.Card(
                          id: 'restaurant',
                          menuSection: 'Restaurant',
                          title: 'Restaurant',
                        ),
                        home_model.Card(
                          id: 'express',
                          menuSection: 'Express',
                          title: 'Express',
                        ),
                        home_model.Card(
                          id: 'cafe',
                          menuSection: 'Cafe',
                          title: 'Cafe',
                        ),
                      ]
                    : cards)
                .map((card) {
              final cardName =
                  card.menuSection ?? card.title ?? card.id ?? 'Restaurant';
              final targetEndpoint = _getEndpointForCard(cardName);
              final iconData = _getIconForCard(cardName);

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.to(
                      () => RestaurantMenuScreen(endpoint: targetEndpoint),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    padding: EdgeInsets.symmetric(
                      vertical: 16.h,
                      horizontal: 8.w,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0x9DFFF8F2),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: AppColor.primaryColor.withValues(alpha: 0.15),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (card.imageUrl != null && card.imageUrl!.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: Image.network(
                              card.imageUrl!,
                              height: 42.r,
                              width: 42.r,
                              fit: BoxFit.cover,
                              errorBuilder: (c, e, s) => Container(
                                height: 42.r,
                                width: 42.r,
                                decoration: BoxDecoration(
                                  color: AppColor.primaryColor.withValues(
                                    alpha: 0.1,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  iconData,
                                  color: AppColor.primaryColor,
                                  size: 24.sp,
                                ),
                              ),
                            ),
                          )
                        else
                          Container(
                            height: 48.r,
                            width: 48.r,
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor.withValues(
                                alpha: 0.1,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                iconData,
                                color: AppColor.primaryColor,
                                size: 26.sp,
                              ),
                            ),
                          ),
                        SizedBox(height: 10.h),
                        TextWidget(
                          text: cardName,
                          color: AppColor.black100,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
