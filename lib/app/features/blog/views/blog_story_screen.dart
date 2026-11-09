import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../utils/svg_icon.dart';
import '../../../../widgets/loader/loader.dart';
import '../../../../widgets/text_widget.dart';
import '../controller/blog_controller.dart';

class BlogStoryScreen extends StatefulWidget {
  const BlogStoryScreen({super.key, required this.slug});

  final String slug;

  @override
  State<BlogStoryScreen> createState() => _BlogStoryScreenState();
}

class _BlogStoryScreenState extends State<BlogStoryScreen> {
  final BlogController blogController = Get.find<BlogController>();

  @override
  void initState() {
    super.initState();
    blogController.getBlogDetail(widget.slug);
  }

  @override
  Widget build(BuildContext context) {
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
        () => blogController.isDetailLoading.value
            ? const Center(child: LoaderCircle())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Banner matching screenshot ("From the Alkaderia Kitchen", "Our stories")
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 36.h,
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
                            text: 'Our stories',
                            color: const Color(0xFF1A1A1A),
                            textAlign: TextAlign.center,
                            fontSize: 28.sp,
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

                    SizedBox(height: 20.h),

                    // Blog Details Content
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category & Date
                          Row(
                            children: [
                              TextWidget(
                                text: (blogController.blogStoryModel.value.data
                                            ?.category ??
                                        '')
                                    .toUpperCase(),
                                color: const Color(0xFF8C6D3B),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              if (blogController.blogStoryModel.value.data
                                          ?.category !=
                                      null &&
                                  blogController.blogStoryModel.value.data!
                                      .category!.isNotEmpty &&
                                  blogController.blogStoryModel.value.data
                                          ?.publishedAt !=
                                      null)
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
                              if (blogController.blogStoryModel.value.data
                                      ?.publishedAt !=
                                  null)
                                TextWidget(
                                  text:
                                      '${_getMonthName(blogController.blogStoryModel.value.data!.publishedAt!.month)} ${blogController.blogStoryModel.value.data!.publishedAt!.day}, ${blogController.blogStoryModel.value.data!.publishedAt!.year}'
                                          .toUpperCase(),
                                  color: const Color(0xFF8C6D3B),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                            ],
                          ),
                          SizedBox(height: 16.h),

                          // Blog Title
                          TextWidget(
                            text: blogController
                                    .blogStoryModel.value.data?.title ??
                                '',
                            color: AppColor.black100,
                            fontSize: 26.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(height: 16.h),

                          // Excerpt / Subtitle intro
                          if (blogController.blogStoryModel.value.data
                                      ?.excerpt !=
                                  null &&
                              blogController.blogStoryModel.value.data!.excerpt!
                                  .isNotEmpty)
                            TextWidget(
                              text: blogController
                                  .blogStoryModel.value.data!.excerpt!,
                              color: const Color(0xFF333333),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),

                    // Featured Image
                    if (blogController.blogStoryModel.value.data?.imageUrl !=
                            null &&
                        blogController.blogStoryModel.value.data!.imageUrl!
                            .isNotEmpty)
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.r),
                          child: Image.network(
                            blogController
                                .blogStoryModel.value.data!.imageUrl!,
                            height: 260.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                height: 260.h,
                                width: double.infinity,
                                color: Colors.grey[100],
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                    color: AppColor.primaryColor,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  height: 260.h,
                                  color: Colors.grey[200],
                                  child: const Center(
                                    child: Icon(Icons.image, color: Colors.grey),
                                  ),
                                ),
                          ),
                        ),
                      ),

                    SizedBox(height: 24.h),

                    // Main Content / Body Paragraphs
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: TextWidget(
                        text: blogController.blogStoryModel.value.data?.body ??
                            '',
                        color: const Color(0xFF222222),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    SizedBox(height: 40.h),
                  ],
                ),
              ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}
