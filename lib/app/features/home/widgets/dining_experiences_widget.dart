import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodnanny/app/features/home/model/home_response_model.dart'
    as home_model;
import 'package:foodnanny/config/theme/app_color.dart';
import 'package:foodnanny/widgets/text_widget.dart';

class DiningExperiencesWidget extends StatelessWidget {
  const DiningExperiencesWidget({super.key, required this.section});

  final home_model.Section section;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
            ),
          SizedBox(height: 6.h),
          if (section.subtitle != null)
            TextWidget(
              text: section.subtitle!,
              color: const Color(0xFF666666),
              fontSize: 14.sp,
            ),
          SizedBox(height: 16.h),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: section.cards?.length ?? 0,
            itemBuilder: (context, index) {
              final card = section.cards![index];
              return Container(
                margin: EdgeInsets.only(bottom: 20.h),
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: AppColor.black20.withValues(alpha: 0.5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (card.imageUrl != null && card.imageUrl!.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16.r),
                        ),
                        child: Image.network(
                          card.imageUrl!,
                          height: 200.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, s) => const SizedBox.shrink(),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (card.eyebrow != null)
                            TextWidget(
                              text: card.eyebrow!.toUpperCase(),
                              color: AppColor.primaryColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          SizedBox(height: 8.h),
                          if (card.title != null)
                            TextWidget(
                              text: card.title!,
                              color: AppColor.black100,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          SizedBox(height: 8.h),
                          if (card.description != null)
                            TextWidget(
                              text: card.description!,
                              color: const Color(0xFF555555),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          if (card.action != null) ...[
                            SizedBox(height: 16.h),
                            Divider(color: AppColor.black20, thickness: 1),
                            SizedBox(height: 12.h),
                            GestureDetector(
                              onTap: () {},
                              child: Row(
                                children: [
                                  TextWidget(
                                    text: card.action!.label ?? 'View Menu',
                                    color: AppColor.primaryColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(width: 6.w),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 16.sp,
                                    color: AppColor.primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
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
