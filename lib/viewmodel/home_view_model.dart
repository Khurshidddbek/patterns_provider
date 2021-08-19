
import 'package:flutter/foundation.dart';
import 'package:patterns_provider/model/post_model.dart';
import 'package:patterns_provider/services/http_service.dart';

class HomeViewModel extends ChangeNotifier {
  List<Post> items = List();
  bool isLoading = false;

  Future apiPostList() async {
    isLoading = true;
    notifyListeners();

    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());

    if (response != null) {
      items = Network.parsePostList(response);
    }

    isLoading = false;
    notifyListeners();
  }

  Future<bool> apiPostDelete(Post post) async {
    isLoading = true;
    notifyListeners();

    var response = await Network.DEL(Network.API_DELETE + post.id.toString(), Network.paramsEmpty());

    isLoading = false;
    notifyListeners();

    return response != null;
  }

}