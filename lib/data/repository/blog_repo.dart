import 'package:foodnanny/data/server/server.dart';
import 'package:foodnanny/utils/api_list.dart';

class BlogRepo {
  final Server _server = Server();

  Future getBlogs({String? search}) async {
    String endpoint = ApiList.blogPosts;
    if (search != null && search.trim().isNotEmpty) {
      endpoint = '$endpoint?search=${Uri.encodeComponent(search.trim())}';
    }
    final response = await _server.getRequest(endPoint: endpoint);
    return response;
  }

  Future getBlogDetail(String slug) async {
    final response = await _server.getRequest(
      endPoint: ApiList.blogDetails(slug: slug),
    );
    return response;
  }
}
