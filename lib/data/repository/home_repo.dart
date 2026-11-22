import 'package:foodnanny/data/server/server.dart';
import 'package:foodnanny/utils/api_list.dart';

class HomeRepo {
  final Server _server = Server();

  Future getHomeData() async {
    final response = await _server.getRequest(endPoint: ApiList.home);
    return response;
  }

  Future getMenuData([String? endpoint]) async {
    final targetEndpoint = endpoint ?? ApiList.menuRestaurant;
    final response = await _server.getRequest(endPoint: targetEndpoint);
    return response;
  }

  Future getMenuRestaurant() async {
    return getMenuData(ApiList.menuRestaurant);
  }
}
