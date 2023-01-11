// ignore_for_file: file_names, must_be_immutable, avoid_print, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:music/api/index.dart';
import 'package:music/widgets/playlistCover/index.dart';
import 'package:music/utils/format.dart';
import 'package:music/widgets/playlistItem/index.dart';

var api = Api();
var format = Format();
var params;
var playlist;
List<dynamic> playlistMusics = [];

class PlayList extends StatefulWidget {
  const PlayList({Key? key}) : super(key: key);

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  final GlobalKey centerDetailKey = GlobalKey();
  void _getDetail() {
    api.getPlaylistDetail(params['id']).then((value) {
      setState(() {
        print(value);
        playlist = value['playlist'];
      });
    });
  }

  void _getMusics() {
    api.getPlaylistMusics(params['id']).then(
      (value) {
        print(value);
        setState(() {
          playlistMusics = value['songs'];
        });
      },
    );
  }

  void getParmas() {
    params = ModalRoute.of(context)?.settings.arguments;
  }

  @override
  void initState() {
    Future.microtask(getParmas).then((value) {
      _getDetail();
      _getMusics();
    });
    super.initState();
  }

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
      body: Stack(
        children: [
          const PlaylistDetail(),
          Align(
            alignment: const FractionalOffset(0.5, 0.23),
            key: centerDetailKey,
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    width: 0.5,
                    color: const Color.fromARGB(255, 126, 126, 126)),
                color: Colors.white,
              ),
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(children: [
                        const Icon(
                          Icons.collections,
                          size: 14,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          format.formatPlayCount(
                              playlist['subscribedCount'].toString()),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ]),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(children: [
                        const Icon(Icons.message, size: 14),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                            format.formatPlayCount(
                                playlist['commentCount'].toString()),
                            style: const TextStyle(fontSize: 12))
                      ]),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(children: [
                        const Icon(Icons.share, size: 14),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                            format.formatPlayCount(
                                playlist['shareCount'].toString()),
                            style: const TextStyle(fontSize: 12))
                      ]),
                    ),
                  ]),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 150),
              child: ListView(
                children: playlistMusics.asMap().entries.map((e) {
                  var value = e.value;
                  var index = e.key;
                  return PlaylistItem(
                    name: value['name'],
                    musicId: value['id'],
                    index: index,
                    singer: value['ar'],
                    album: value['al'],
                    mvId: value['mv'] == 0 ? null : value['mv'],
                  );
                }).toList(),
              ))
        ],
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
  void _getDetail() {
    api.getPlaylistDetail(params['id']).then((value) {
      setState(() {
        playlist = value['playlist'];
      });
    });
  }

  @override
  void initState() {
    _getDetail();
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
      child: Stack(
        children: [
          Row(
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
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                          playlist['creator']['avatarUrl']),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    playlist['creator']['nickname'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 197, 197, 197),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 2, 5, 2),
                                          color: const Color.fromARGB(
                                              255, 106, 106, 106),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.add,
                                                size: 12,
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 2),
                                                child: const Text(
                                                  '关注',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Color.fromARGB(
                                                          255, 180, 180, 180)),
                                                ),
                                              )
                                            ],
                                          )),
                                    ),
                                  )
                                ],
                              )),
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
        ],
      ),
    );
  }
}
