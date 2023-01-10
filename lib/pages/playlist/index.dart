// ignore_for_file: file_names, must_be_immutable, avoid_print, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:music/api/index.dart';
import 'package:music/widgets/playlistCover/index.dart';

var api = Api();

class PlayList extends StatefulWidget {
  const PlayList({Key? key}) : super(key: key);

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 62, 62, 65),
                Color.fromARGB(255, 28, 29, 29),
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
            ),
          ),
          actions: const [
            InkWell(
              child: Icon(Icons.search),
            ),
            InkWell(
              child: Icon(Icons.more_vert_outlined),
            ),
          ],
          title: const Center(
            child: Text(
              '歌 单',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          )),
      body: ListView(
        children: const [PlaylistDetail()],
      ),
    );
  }
}

class PlaylistDetail extends StatefulWidget {
  const PlaylistDetail({Key? key}) : super(key: key);

  @override
  State<PlaylistDetail> createState() => _PlaylistDetailState();
}

class _PlaylistDetailState extends State<PlaylistDetail> {
  var params;
  var playlist;
  void _getDetail() {
    api.getPlaylistDetail(params['id']).then((value) {
      setState(() {
        print(value);
        playlist = value['playlist'];
      });
    });
  }

  void getParmas() {
    params = ModalRoute.of(context)?.settings.arguments;
  }

  @override
  void initState() {
    Future.microtask(getParmas).then((value) {
      _getDetail();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
            Color.fromARGB(255, 62, 62, 65),
            Color.fromARGB(255, 28, 29, 29),
          ])),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PlaylistCover(
                cover: playlist['coverImgUrl'],
                playCount: playlist['playCount'],
                notShowIcon: true,
                notShowPlayIcon: true,
              )
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: Text(
                          playlist['name'],
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: const Text(
                          '1111111111111111111111111111111111111111111111111111111111111',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Color.fromARGB(255, 197, 197, 197),
                              fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.8,
                        height: 20,
                        child: Text(
                          playlist['description'],
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 197, 197, 197),
                              fontSize: 12),
                        ),
                      ),
                    ]),
              )
            ],
          )
        ],
      ),
    );
  }
}
