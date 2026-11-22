import 'package:foodnanny/data/server/server.dart';
import 'package:foodnanny/utils/api_list.dart';

class MenuRepo {
  final Server _server = Server();

  Future getHomeMenu() async {
    final response = await _server.getRequest(endPoint: ApiList.homeMenu);
    return response;
  }
}
