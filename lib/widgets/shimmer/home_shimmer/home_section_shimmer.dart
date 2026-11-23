import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class HomeSectionShimmer extends StatelessWidget {
  const HomeSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Search Bar Skeleton
              Container(
                height: 50.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.r),
                ),
              ),
              SizedBox(height: 20.h),

              // 2. 3 Category Cards Skeleton (Restaurant, Express, Cafe)
              Row(
                children: List.generate(
                  3,
                  (index) => Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      height: 110.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // 3. Signature Dishes Carousel Skeleton
              Container(
                height: 18.h,
                width: 150.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
              SizedBox(height: 12.h),

              // Filter chips row
              Row(
                children: List.generate(
                  4,
                  (index) => Container(
                    margin: EdgeInsets.only(right: 10.w),
                    height: 36.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Horizontal Cards ListView
              SizedBox(
                height: 240.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) => Container(
                    width: 220.w,
                    margin: EdgeInsets.only(right: 14.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // 4. Menu Book Vertical List Skeleton
              Container(
                height: 18.h,
                width: 180.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
              SizedBox(height: 14.h),

              // Vertical list of horizontal cards
              Column(
                children: List.generate(
                  3,
                  (index) => Container(
                    margin: EdgeInsets.only(bottom: 14.h),
                    height: 120.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // 5. Restaurant Info Card Skeleton
              Container(
                height: 140.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
