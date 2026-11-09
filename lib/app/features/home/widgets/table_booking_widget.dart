import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodnanny/app/features/home/model/home_response_model.dart'
    as home_model;
import 'package:foodnanny/config/theme/app_color.dart';
import 'package:foodnanny/widgets/text_widget.dart';

class BookingSectionWidget extends StatelessWidget {
  const BookingSectionWidget({super.key, required this.section});

  final home_model.Section section;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric( vertical: 16.h),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColor.primaryColor,

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (section.eyebrow != null)
            TextWidget(
              text: section.eyebrow!.toUpperCase(),
              color: Colors.white,
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
            ),
          SizedBox(height: 12.h),
          if (section.title != null)
            TextWidget(
              text: section.title!,
              color: Colors.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
            ),
          SizedBox(height: 12.h),
          if (section.description != null)
            TextWidget(
              text: section.description!,
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColor.primaryColor,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.phone_outlined,
                  size: 18.sp,
                  color: AppColor.primaryColor,
                ),
                SizedBox(width: 8.w),
                TextWidget(
                  text: section.action?.label ?? 'Call to book a table',
                  color: AppColor.primaryColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
