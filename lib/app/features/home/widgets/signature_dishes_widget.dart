import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodnanny/app/features/home/model/home_response_model.dart'
    as home_model;
import 'package:foodnanny/config/theme/app_color.dart';
import 'package:foodnanny/widgets/add_to_cart_dialog.dart';
import 'package:foodnanny/widgets/text_widget.dart';

class SignatureDishesWidget extends StatefulWidget {
  const SignatureDishesWidget({super.key, required this.section});

  final home_model.Section section;

  @override
  State<SignatureDishesWidget> createState() => _SignatureDishesWidgetState();
}

class _SignatureDishesWidgetState extends State<SignatureDishesWidget> {
  String selectedFilterId = 'All';

  @override
  void initState() {
    super.initState();
    if (widget.section.filters != null && widget.section.filters!.isNotEmpty) {
      selectedFilterId = widget.section.filters!.first.id ?? 'All';
    } else if (widget.section.defaultFilter != null) {
      selectedFilterId = widget.section.defaultFilter!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filters = widget.section.filters ?? [];
    final allItems = widget.section.items ?? [];

    List<home_model.Item> displayedItems = allItems;
    if (selectedFilterId != 'All') {
      home_model.Filter? matchedFilter;
      try {
        matchedFilter = filters.firstWhere((f) => f.id == selectedFilterId);
      } catch (e) {
        matchedFilter = null;
      }
      if (matchedFilter != null && matchedFilter.itemIds != null) {
        displayedItems = allItems
            .where((item) => matchedFilter!.itemIds!.contains(item.id))
            .toList();
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
          if (widget.section.title != null && widget.section.title!.isNotEmpty) ...[
            SizedBox(height: 4.h),
            TextWidget(
              text: widget.section.title!,
              color: AppColor.black100,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ],
          SizedBox(height: 12.h),

          // Filter Chips
          if (filters.isNotEmpty)
            SizedBox(
              height: 38.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  final isSelected = selectedFilterId == filter.id;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilterId = filter.id ?? 'All';
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10.w),
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.w,
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
                          text: filter.id ?? '',
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
          SizedBox(height: 16.h),

          // Horizontal Scrollable Items (Left to Right)
          displayedItems.isEmpty
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.h),
                  child: Center(
                    child: TextWidget(
                      text: 'No dishes found in this category',
                      color: AppColor.black80,
                      fontSize: 14.sp,
                    ),
                  ),
                )
              : SizedBox(
                  height: 240.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: displayedItems.length,
                    itemBuilder: (context, index) {
                      final item = displayedItems[index];
                      final imageUrl = item.thumb ?? item.cover ?? '';
                      final fullImageUrl = imageUrl.startsWith('http')
                          ? imageUrl
                          : 'https://hotel.w3informer.com$imageUrl';

                      final unitPrice = double.tryParse(
                              item.flatDiscountedPrice ?? item.flatPrice ?? '0') ??
                          0.0;
                      final originalPrice =
                          double.tryParse(item.flatPrice ?? '0') ?? 0.0;

                      return GestureDetector(
                        onTap: () {
                          AddToCartDialog.show(
                            context: context,
                            id: item.id ?? 0,
                            name: item.name ?? '',
                            description: item.description,
                            imageUrl: item.thumb ?? item.cover,
                            unitPrice: unitPrice,
                            originalPrice:
                                originalPrice > unitPrice ? originalPrice : null,
                          );
                        },
                        child: Container(
                          width: 220.w,
                          margin: EdgeInsets.only(right: 14.w),
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
                                  height: 125.h,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (c, e, s) => Container(
                                    height: 125.h,
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
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            text: item.name ?? '',
                                            color: AppColor.black100,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 2.h),
                                          TextWidget(
                                            text: item.categoryName ??
                                                'Signature Dish',
                                            color: const Color(0xFF777777),
                                            fontSize: 12.sp,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
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
                                              Container(
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
                                                          .withValues(
                                                              alpha: 0.3),
                                                      blurRadius: 6,
                                                      offset:
                                                          const Offset(0, 3),
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ],
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
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
