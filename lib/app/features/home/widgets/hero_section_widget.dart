import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodnanny/app/features/home/model/home_response_model.dart'
    as home_model;
import 'package:foodnanny/config/theme/app_color.dart';
import 'package:foodnanny/widgets/text_widget.dart';

class HeroSectionWidget extends StatelessWidget {
  const HeroSectionWidget({super.key, required this.section});

  final home_model.Section section;

  @override
  Widget build(BuildContext context) {
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
              maxLines: 1,
            ),
          SizedBox(height: 12.h),
          if (section.title != null)
            RichText(
              text: TextSpan(
                text: '${section.title!}\n',
                style: TextStyle(
                  color: AppColor.black100,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  height: 1.15,
                  fontFamily: 'Rubik',
                ),
                children: [
                  if (section.highlight != null)
                    TextSpan(
                      text: section.highlight!,
                      style: TextStyle(
                        color: AppColor.primaryColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                ],
              ),
            ),
          SizedBox(height: 12.h),
          if (section.subtitle != null)
            TextWidget(
              text: section.subtitle!,
              color: const Color(0xFF666666),
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
            ),
          if (section.actions != null && section.actions!.isNotEmpty) ...[
            SizedBox(height: 24.h),
            Row(
              children: section.actions!.asMap().entries.map((entry) {
                final int idx = entry.key;
                final action = entry.value;
                final isPrimary = idx == 0;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: idx == 0 ? 10.w : 0.h),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isPrimary ? AppColor.primaryColor : Colors.white,
                        foregroundColor:
                            isPrimary ? Colors.white : AppColor.primaryColor,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          side: BorderSide(
                            color: AppColor.primaryColor,
                            width: 1.5.w,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                            text: action.label ?? '',
                            color:
                                isPrimary ? Colors.white : AppColor.primaryColor,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          if (isPrimary) ...[
                            SizedBox(width: 6.w),
                            Icon(
                              Icons.arrow_forward,
                              size: 14.sp,
                              color: Colors.white,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
          if (section.imageUrl != null && section.imageUrl!.isNotEmpty) ...[
            SizedBox(height: 28.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Image.network(
                  section.imageUrl!,
                  height: 240.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => const SizedBox.shrink(),
                ),
              ),
            ),
          ],
          if (section.info != null) ...[
            SizedBox(height: 24.h),
            Container(
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
                              text: section.info!.title ?? '',
                              color: AppColor.black100,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 2.h),
                            TextWidget(
                              text: section.info!.text ?? '',
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
                              text: section.info!.hours ?? '',
                              color: AppColor.black100,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 2.h),
                            TextWidget(
                              text: section.info!.hoursText ?? '',
                              color: const Color(0xFF666666),
                              fontSize: 12.sp,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (section.info!.phone != null) ...[
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
                                text: 'Call ${section.info!.phone!}',
                                color: AppColor.black100,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(height: 2.h),
                              TextWidget(
                                text:
                                    section.info!.phoneText ??
                                    'We\'re here to help',
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
            ),
          ],
        ],
      ),
    );
  }
}
