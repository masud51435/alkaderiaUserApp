import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodnanny/app/features/bottom_navbar/controller/navbar_controller.dart';
import 'package:foodnanny/app/features/home/model/home_response_model.dart'
    as home_model;
import 'package:foodnanny/config/theme/app_color.dart';
import 'package:foodnanny/widgets/text_widget.dart';
import 'package:get/get.dart';

class HeroSectionWidget extends StatelessWidget {
  const HeroSectionWidget({super.key, required this.section});

  final home_model.Section section;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
      child: GestureDetector(
        onTap: () {
          final navController = Get.find<NavbarController>();
          navController.changePage(1);
        },
        child: Container(
          height: 50.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25.r),
            border: Border.all(
              color: AppColor.black40.withValues(alpha: 0.5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                Icons.search_rounded,
                color: AppColor.primaryColor,
                size: 22.sp,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: TextWidget(
                  text: 'Search for dishes, restaurants or drinks...',
                  color: const Color(0xFF888888),
                  fontSize: 14.sp,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.tune_rounded,
                  color: AppColor.primaryColor,
                  size: 16.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
