import '../utils/http.dart';

var http = HttpUtils();

class Api {
  // 获取发现页面banner
  Future getBanners() async {
    return await http.get('/banner?type=1');
  }

  // 获取每日推荐(未登录)
  Future getPersonalized() async {
    return await http.get('/personalized');
  }

  // 获取歌单详情
  Future getPlaylistDetail(id) async {
    return await http.get(
      '/playlist/detail?id=$id',
    );
  }

  // 获取歌单所有歌曲
  Future getPlaylistMusics(id) async {
    return await http.get(
      '/playlist/track/all?id=$id',
    );
  }
}
