// ignore_for_file: must_be_immutable, avoid_print, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class PlaylistItem extends StatefulWidget {
  int? index;
  String name = '';
  List? singer;
  var album;
  int? mvId;
  int musicId;
  Function? playMV;
  Function? playMusic;
  PlaylistItem(
      {Key? key,
      required this.name,
      required this.musicId,
      this.index,
      this.singer,
      this.album,
      this.mvId,
      this.playMV,
      this.playMusic})
      : super(key: key);

  @override
  State<PlaylistItem> createState() => _PlaylistItemState();
}

class _PlaylistItemState extends State<PlaylistItem> {
  _getDesc() {
    var result = '';
    if (widget.singer == null && widget.album == null) {
      result = '';
    } else {
      var singer = '';
      var album = '';
      for (var element in widget.singer!) {
        singer += element['name'] + '/';
      }
      album = widget.album!['name'];
      result = '$singer-$album';
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    var notShowMVIcon = widget.mvId != null ? false : true;
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Row(
        children: [
          Text((widget.index! + 1).toString()),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 150,
                        child: Text(
                          widget.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.grade,
                            size: 12,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text(
                              _getDesc(),
                              style: const TextStyle(
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                  color: Color.fromARGB(255, 130, 129, 129)),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              onTap: () {
                widget.playMusic!(widget.musicId);
              },
            ),
          ),
          Offstage(
            offstage: notShowMVIcon,
            child: IconButton(
              icon: const Icon(
                Icons.play_circle_fill_sharp,
                size: 18,
              ),
              onPressed: () {
                widget.playMV!(widget.mvId);
              },
            ),
          ),
          const Icon(
            Icons.more_vert_outlined,
            size: 18,
          )
        ],
      ),
    );
  }
}
