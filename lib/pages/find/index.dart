// ignore_for_file: file_names, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../api/index.dart';
import '../../widgets/drawer/index.dart';

class Find extends StatefulWidget {
  const Find({Key? key}) : super(key: key);

  @override
  State<Find> createState() => _FindState();
}

class _FindState extends State<Find> {
  var keywords = TextEditingController();
  List<Widget> layoutItems = [Banner()];

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
                hintText: '周杰伦(Jay)',
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
                    height: 175,
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
