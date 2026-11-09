import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodnanny/app/features/home/model/home_response_model.dart'
    as home_model;
import 'package:foodnanny/config/theme/app_color.dart';
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
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Eyebrow
          if (widget.section.eyebrow != null)
            Center(
              child: TextWidget(
                text: widget.section.eyebrow!.toUpperCase(),
                color: AppColor.primaryColor,
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          SizedBox(height: 6.h),
          // Title
          if (widget.section.title != null)
            Center(
              child: TextWidget(
                text: widget.section.title!,
                color: AppColor.black100,
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
            ),
          SizedBox(height: 16.h),

          // Filter Chips
          if (filters.isNotEmpty)
            SizedBox(
              height: 44.h,
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
                          text: filter.id ?? '',
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

          // Items GridView (2 cards side by side)
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
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
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
                              padding: EdgeInsets.all(10.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextWidget(
                                    text: item.name ?? '',
                                    color: AppColor.black100,
                                    fontSize: 14.sp,
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
                                          fontSize: 12.sp,
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
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(width: 4.w),
                                          Container(
                                            height: 32.r,
                                            width: 32.r,
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
        ],
      ),
    );
  }
}
