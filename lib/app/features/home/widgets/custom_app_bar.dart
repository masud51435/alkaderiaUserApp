import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../utils/svg_icon.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.onTap, required this.pickedAddress});
  final void Function()? onTap;
  final String pickedAddress;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(64.h);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.h),
      child: Container(
        height: 64.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          boxShadow: [
            BoxShadow(
              color: AppColor.blackColor.withValues(alpha: 0.04),
              offset: Offset(0, 6),
              blurRadius: 32.r,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                SvgIcon.logo,
                height: 28.h,
                width: 115.w,
                fit: BoxFit.contain,
              ),
              GestureDetector(
                onTap: () {
                  // Notification click action
                },
                child: Container(
                  height: 40.r,
                  width: 40.r,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAF7F2),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColor.black20.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.notifications_outlined,
                      color: AppColor.black100,
                      size: 22.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
