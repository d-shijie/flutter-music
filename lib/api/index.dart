import '../utils/http.dart';

var http = HttpUtils();

class Api {
  Future getBanners() async {
    return await http.get('/banner?type=1');
  }

  Future getPersonalized() async {
    return await http.get('/personalized');
  }
}
