import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../utils/svg_icon.dart';
import '../../../../widgets/loader/loader.dart';
import '../../../../widgets/text_widget.dart';
import '../controller/blog_controller.dart';
import 'blog_story_screen.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BlogController blogController = Get.put(BlogController());

    return Scaffold(
      backgroundColor: const Color(0xFFFBF8F2),
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        elevation: 0,
        surfaceTintColor: AppColor.whiteColor,
        leading: IconButton(
          icon: Container(
            height: 24.h,
            width: 24.w,
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              shape: BoxShape.circle,
              border: Border.all(color: AppColor.primaryColor),
            ),
            child: Padding(
              padding: EdgeInsets.all(4.r),
              child: SvgPicture.asset(
                SvgIcon.arrowLeftCircle,
                height: 24.h,
                width: 24.w,
                colorFilter: ColorFilter.mode(
                  AppColor.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          onPressed: () => Get.back(),
        ),
        title: TextWidget(
          text: 'BLOG'.tr,
          color: AppColor.black100,
          fontWeight: FontWeight.w600,
          fontSize: 18.sp,
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => blogController.isLoading.value
            ? const Center(child: LoaderCircle())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    // Header Section
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 32.h,
                      ),
                      color: const Color(0xFFF9F3E8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextWidget(
                            text: 'FROM THE ALKADERIA KITCHEN',
                            color: const Color(0xFF8C6D3B),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(height: 12.h),
                          TextWidget(
                            text: 'Stories, flavours & inspiration',
                            color: const Color(0xFF1A1A1A),
                            textAlign: TextAlign.center,
                            fontSize: 26.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(height: 10.h),
                          TextWidget(
                            text:
                                'Food we love. Moments we share. The latest from Alkaderia.',
                            color: const Color(0xFF666666),
                            textAlign: TextAlign.center,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),

                    // Search Bar Section
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 20.h,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: AppColor.black20),
                              ),
                              child: TextField(
                                controller: blogController.searchController,
                                onChanged: (value) {
                                  blogController.onSearchChanged(value);
                                },
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColor.black100,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Search stories or categories',
                                  hintStyle: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColor.black80,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 14.h,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          SizedBox(
                            height: 50.h,
                            child: ElevatedButton(
                              onPressed: () {
                                blogController.getBlogs(
                                  search: blogController.searchController.text,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                elevation: 0,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                ),
                              ),
                              child: TextWidget(
                                text: 'Search',
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Blog List using ListView.builder with dynamic data from API
                    blogController.filteredBlogs.isEmpty
                        ? Padding(
                            padding: EdgeInsets.symmetric(vertical: 40.h),
                            child: TextWidget(
                              text: 'No blog posts found',
                              color: AppColor.black80,
                              fontSize: 16.sp,
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: blogController.filteredBlogs.length,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            itemBuilder: (context, index) {
                              final blog =
                                  blogController.filteredBlogs[index];
                              final dateStr = blog.publishedAt != null
                                  ? '${blog.publishedAt!.day}-${blog.publishedAt!.month}-${blog.publishedAt!.year}'
                                  : '';
                              return Container(
                                margin: EdgeInsets.only(bottom: 20.h),
                                decoration: BoxDecoration(
                                  color: AppColor.whiteColor,
                                  borderRadius: BorderRadius.circular(16.r),
                                  border: Border.all(
                                    color: AppColor.black20.withValues(
                                      alpha: 0.5,
                                    ),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.03,
                                      ),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    if (blog.imageUrl != null &&
                                        blog.imageUrl!.isNotEmpty)
                                      ClipRRect(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16.r),
                                        ),
                                        child: Image.network(
                                          blog.imageUrl!,
                                          height: 220.h,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child, loadingProgress) {
                                            if (loadingProgress == null) return child;
                                            return Container(
                                              height: 220.h,
                                              width: double.infinity,
                                              color: Colors.grey[100],
                                              child: Center(
                                                child: CircularProgressIndicator(
                                                  value: loadingProgress.expectedTotalBytes != null
                                                      ? loadingProgress.cumulativeBytesLoaded /
                                                          loadingProgress.expectedTotalBytes!
                                                      : null,
                                                  color: AppColor.primaryColor,
                                                ),
                                              ),
                                            );
                                          },
                                          errorBuilder: (context, error, stackTrace) =>
                                              Container(
                                                height: 220.h,
                                                color: Colors.grey[200],
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.image_not_supported_outlined,
                                                      size: 32.sp,
                                                      color: Colors.grey,
                                                    ),
                                                    SizedBox(height: 8.h),
                                                    TextWidget(
                                                      text: 'Image not available',
                                                      color: Colors.grey,
                                                      fontSize: 12.sp,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                        ),
                                      ),
                                    Padding(
                                      padding: EdgeInsets.all(20.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              TextWidget(
                                                text: blog.category ?? '',
                                                color: AppColor.primaryColor,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              if (blog.category != null &&
                                                  blog.category!.isNotEmpty &&
                                                  dateStr.isNotEmpty)
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 8.w,
                                                  ),
                                                  child: TextWidget(
                                                    text: '•',
                                                    color: AppColor.black80,
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                              TextWidget(
                                                text: dateStr,
                                                color: AppColor.black80,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 12.h),
                                          TextWidget(
                                            text: blog.title ?? '',
                                            color: AppColor.black100,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 10.h),
                                          TextWidget(
                                            text: blog.excerpt ?? '',
                                            color: const Color(0xFF555555),
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 16.h),
                                          Divider(
                                            color: AppColor.black20,
                                            thickness: 1,
                                          ),
                                          SizedBox(height: 12.h),
                                          GestureDetector(
                                            onTap: () {
                                              Get.to(
                                                () => BlogStoryScreen(
                                                  slug: blog.slug ?? '',
                                                ),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                TextWidget(
                                                  text: 'Read story',
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
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
      ),
    );
  }
}
