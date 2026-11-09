import 'package:foodnanny/data/server/server.dart';
import 'package:foodnanny/utils/api_list.dart';

class HomeRepo {
  final Server _server = Server();

  Future getHomeData() async {
    final response = await _server.getRequest(endPoint: ApiList.home);
    return response;
  }
}
