// ignore_for_file: file_names, must_be_immutable, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../api/index.dart';
import '../../widgets/drawer/index.dart';
import '../../widgets/title/index.dart';
import '../../widgets/bottomSheet/index.dart';

class Find extends StatefulWidget {
  const Find({Key? key}) : super(key: key);

  @override
  State<Find> createState() => _FindState();
}

class _FindState extends State<Find> {
  var keywords = TextEditingController();
  List<Widget> layoutItems = [
    Banner(),
    const ITapBar(),
    const RecommandPlayList()
  ];
  final List<String> hintTexts = [
    '周杰伦(Jay)',
    '林俊杰(JJ)',
    '五月天',
    '薛之谦',
    '不分手的恋爱'
  ];
  int count = 0;
  String hintText = '';
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (count == hintTexts.length) {
        count = 0;
      }
      setState(() {
        hintText = hintTexts[count];
      });
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(750, 1624));
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            child: Container(
                margin: EdgeInsets.only(right: 15.w),
                child: const Icon(Icons.mic)),
          )
        ],
        title: Container(
            height: 30,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 223, 225, 243),
              border: Border.all(
                  color: const Color.fromARGB(255, 223, 225, 243), width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              controller: keywords,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        const BorderSide(width: 0, color: Colors.transparent)),
                hintText: hintText,
                prefixIcon: const Icon(Icons.search),
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            )),
      ),
      // 每个listview item设置16向下的距离
      body: ListView.separated(
          itemBuilder: (context, index) {
            return layoutItems[index];
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(
                height: 16,
                color: Colors.white,
              ),
          itemCount: layoutItems.length),
      drawer: const Drawer(
        // width: 200,
        child: APPDrawer(),
      ),
    );
  }
}

class Banner extends StatefulWidget {
  var banners = [];
  Banner({Key? key}) : super(key: key);

  @override
  State<Banner> createState() => _BannerState();
}

class _BannerState extends State<Banner> {
  var api = Api();
  var banners = [];
  _getBanner() async {
    var data = await api.getBanners();
    setState(() {
      banners = data['banners'];
    });
  }

  @override
  void initState() {
    _getBanner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: banners.length,
        itemBuilder: (context, index, realIndex) {
          return Center(
            child: InkWell(
                onTap: () {
                  print(index);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    banners[index]['pic'] ?? '',
                    fit: BoxFit.fill,
                    height: 180,
                  ),
                )),
          );
        },
        options: CarouselOptions(
            enableInfiniteScroll: true,
            autoPlay: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true));
  }
}

class ITapBar extends StatefulWidget {
  const ITapBar({Key? key}) : super(key: key);

  @override
  State<ITapBar> createState() => _ITapBarState();
}

class _ITapBarState extends State<ITapBar> with TickerProviderStateMixin {
  final List<Map> tabbar = [
    {'label': '每日推荐', 'icon': const Icon(Icons.music_note)},
    {'label': '私人FM', 'icon': const Icon(Icons.music_note)},
    {'label': '歌单', 'icon': const Icon(Icons.music_note)},
    {'label': '排行榜', 'icon': const Icon(Icons.music_note)},
    {'label': '有声书', 'icon': const Icon(Icons.music_note)},
    {'label': '数字专辑', 'icon': const Icon(Icons.music_note)},
    {'label': '直播', 'icon': const Icon(Icons.music_note)},
    {'label': '专注新歌', 'icon': const Icon(Icons.music_note)},
    {'label': '一歌一遇', 'icon': const Icon(Icons.music_note)},
    {'label': '收藏家', 'icon': const Icon(Icons.music_note)},
    {'label': '游戏专区', 'icon': const Icon(Icons.music_note)},
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabbar.length,
      child: TabBar(
        indicator: const BoxDecoration(), //去除下划线
        isScrollable: true,
        unselectedLabelColor: const Color.fromARGB(255, 140, 139, 139),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        labelStyle: const TextStyle(fontSize: 12),
        labelColor: const Color.fromARGB(255, 140, 139, 139),
        tabs: tabbar
            .map((e) => Tab(
                  text: e['label'],
                  icon: e['icon'],
                  iconMargin: const EdgeInsets.only(bottom: 0),
                ))
            .toList(),
        onTap: (index) {
          print(index);
        },
      ),
    );
  }
}

class RecommandPlayList extends StatefulWidget {
  const RecommandPlayList({Key? key}) : super(key: key);

  @override
  State<RecommandPlayList> createState() => _RecommandPlayListState();
}

class _RecommandPlayListState extends State<RecommandPlayList> {
  var items = [
    {'text': '优先推荐', 'icon': const Icon(Icons.add_link_rounded)},
    {'text': '减少推荐', 'icon': const Icon(Icons.delete)},
    {'text': '更对内容', 'icon': const Icon(Icons.more_horiz)}
  ];
  @override
  Widget build(BuildContext context) {
    return DTitle(
        text: '推荐歌单',
        prefix: Icons.refresh,
        iconSize: 18,
        fontSize: 12,
        suffix: Icons.chevron_right,
        onTap: () => showMaterialModalBottomSheet(
              expand: false,
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) => ModalFit(
                items: items,
                onTap: (e) {
                  print(e);
                  Navigator.of(context).pop();
                },
              ),
            ));
  }
}
