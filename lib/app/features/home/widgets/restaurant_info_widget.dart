import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodnanny/app/features/home/model/home_response_model.dart'
    as home_model;
import 'package:foodnanny/config/theme/app_color.dart';
import 'package:foodnanny/widgets/text_widget.dart';

class RestaurantInfoWidget extends StatelessWidget {
  const RestaurantInfoWidget({super.key, required this.section});

  final home_model.Section? section;

  @override
  Widget build(BuildContext context) {
    final info = section?.info;
    if (info == null) return const SizedBox.shrink();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF7F2),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColor.black20.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.restaurant_outlined,
                  size: 18.sp,
                  color: AppColor.primaryColor,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: info.title ?? '',
                      color: AppColor.black100,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 2.h),
                    TextWidget(
                      text: info.text ?? '',
                      color: const Color(0xFF666666),
                      fontSize: 12.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Divider(
              color: AppColor.black20.withValues(alpha: 0.3),
              height: 1,
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.access_time_outlined,
                  size: 18.sp,
                  color: AppColor.primaryColor,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: info.hours ?? '',
                      color: AppColor.black100,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 2.h),
                    TextWidget(
                      text: info.hoursText ?? '',
                      color: const Color(0xFF666666),
                      fontSize: 12.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (info.phone != null) ...[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Divider(
                color: AppColor.black20.withValues(alpha: 0.3),
                height: 1,
              ),
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.phone_outlined,
                    size: 18.sp,
                    color: AppColor.primaryColor,
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Call ${info.phone!}',
                        color: AppColor.black100,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 2.h),
                      TextWidget(
                        text: info.phoneText ?? 'We\'re here to help',
                        color: const Color(0xFF666666),
                        fontSize: 12.sp,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
