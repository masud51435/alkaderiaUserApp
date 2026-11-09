import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repository/blog_repo.dart';
import '../model/blog_detail_model.dart';
import '../model/blog_post_model.dart';

class BlogController extends GetxController {
  final BlogRepo _blogRepo = BlogRepo();
  final isLoading = false.obs;
  final isDetailLoading = false.obs;
  final blogPostModel = BlogPostModel().obs;
  final blogStoryModel = BlogStoryModel().obs;
  final filteredBlogs = <Datum>[].obs;
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getBlogs();
  }

  Future<void> getBlogs({String? search}) async {
    try {
      isLoading.value = true;
      final response = await _blogRepo.getBlogs(search: search);
      if (response != null && response.statusCode == 200) {
        blogPostModel.value = BlogPostModel.fromJson(response.data);
        filteredBlogs.value = blogPostModel.value.data ?? [];
      }
    } catch (e) {
      debugPrint('Error fetching blogs: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getBlogDetail(String slug) async {
    try {
      isDetailLoading.value = true;
      final response = await _blogRepo.getBlogDetail(slug);
      if (response != null && response.statusCode == 200) {
        blogStoryModel.value = BlogStoryModel.fromJson(response.data);
      }
    } catch (e) {
      debugPrint('Error fetching blog detail: $e');
    } finally {
      isDetailLoading.value = false;
    }
  }

  void onSearchChanged(String query) {
    if (query.trim().isEmpty) {
      getBlogs(search: '');
    }
  }
}
