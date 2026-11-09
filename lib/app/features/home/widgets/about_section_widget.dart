import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodnanny/app/features/home/model/home_response_model.dart'
    as home_model;
import 'package:foodnanny/config/theme/app_color.dart';
import 'package:foodnanny/widgets/text_widget.dart';

class AboutSectionWidget extends StatelessWidget {
  const AboutSectionWidget({super.key, required this.section});

  final home_model.Section section;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F2),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (section.eyebrow != null)
            TextWidget(
              text: section.eyebrow!.toUpperCase(),
              color: AppColor.primaryColor,
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
            ),
          SizedBox(height: 6.h),
          if (section.title != null)
            TextWidget(
              text: section.title!,
              color: AppColor.black100,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          SizedBox(height: 8.h),
          if (section.paragraphs != null)
            ...section.paragraphs!.map(
              (p) => Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: TextWidget(
                  text: p,
                  color: AppColor.black80,
                  fontSize: 14.sp,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
