// ignore_for_file: must_be_immutable, unnecessary_question_mark

import 'package:flutter/material.dart';
import '../../utils/format.dart';

var format = Format();

class PlaylistCover extends StatefulWidget {
  String cover = '';
  String? desc = '';
  int? playCount = 0;
  bool? notShowPlayIcon = false;
  bool? notShowIcon = true;
  Function? onTap;
  dynamic? object;
  PlaylistCover(
      {Key? key,
      required this.cover,
      this.desc,
      this.playCount,
      this.notShowPlayIcon,
      this.notShowIcon,
      this.onTap,
      this.object})
      : super(key: key);

  @override
  State<PlaylistCover> createState() => _PlaylistCoverState();
}

class _PlaylistCoverState extends State<PlaylistCover> {
  @override
  Widget build(BuildContext context) {
    var notShowDesc = widget.desc != null ? false : true;
    var notShowCount = widget.playCount != null ? false : true;
    return InkWell(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.cover), fit: BoxFit.fill)),
              child: Stack(children: [
                Positioned(
                  right: 5,
                  top: 0,
                  child: Offstage(
                    offstage: notShowCount,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 3),
                          child: const Text(
                            '▶',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 3),
                          child: Text(
                            format.formatPlayCount(widget.playCount.toString()),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 5,
                  bottom: 0,
                  child: Offstage(
                    offstage: widget.notShowPlayIcon ?? false,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 3),
                      child: const Text(
                        '▶',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    left: 5,
                    top: 0,
                    child: Offstage(
                      offstage: widget.notShowIcon ?? false,
                      child: const Icon(Icons.abc),
                    ))
              ]),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Offstage(
            offstage: notShowDesc,
            child: Wrap(
              children: [
                SizedBox(
                  width: 100,
                  height: 35,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    widget.desc ?? '',
                    style:
                        const TextStyle(color: Color.fromARGB(255, 22, 22, 22)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      onTap: () {
        widget.onTap!(widget.object);
      },
    );
  }
}
