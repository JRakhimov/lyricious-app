import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lyricious/src/domain/models/models.dart';
import 'package:lyricious/src/presentation/components/shared/song_tile.dart';
import 'package:lyricious/src/presentation/theme/colors.dart';

class LyricsPage extends StatefulWidget {
  LyricsModel lyrics;

  LyricsPage({required this.lyrics});

  @override
  _LyricsPageState createState() => _LyricsPageState();
}

class _LyricsPageState extends State<LyricsPage> with TickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  bool scroll = false;
  int speedFactor = 20;

  late Color color;

  @override
  void initState() {
    super.initState();

    color = AppColors.getRandomColor();
    Future.delayed(Duration(seconds: 1)).then((value) => _toggleScrolling());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _scroll() {
    double maxExtent = _scrollController.position.maxScrollExtent;
    double distanceDifference = maxExtent - _scrollController.offset;
    double durationDouble = distanceDifference / speedFactor;

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(seconds: durationDouble.toInt()),
      curve: Curves.linear,
    );
  }

  _toggleScrolling() {
    setState(() => scroll = !scroll);

    if (scroll) {
      _scroll();
    } else {
      _scrollController.animateTo(_scrollController.offset, duration: Duration(seconds: 1), curve: Curves.linear);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lines = widget.lyrics.content.replaceAll("\n\n", "\n").split("\n");

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SafeArea(
              child: SongTile(
                song: widget.lyrics.song,
                albumColor: color,
                isLight: true,
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  child: NotificationListener(
                    onNotification: (notif) {
                      if (notif is ScrollEndNotification && scroll) {
                        Timer(Duration(seconds: 1), () => _scroll());
                      }

                      return true;
                    },
                    child: ListView.separated(
                      controller: _scrollController,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, i) {
                        final style = TextStyle(
                          fontSize: 28,
                          fontFamily: "Gilroy",
                          fontWeight: FontWeight.w700,
                        );

                        if (i == 0) return Text("Source: ${widget.lyrics.service}", style: style);

                        return Text(lines[i - 1], style: style);
                      },
                      separatorBuilder: (context, i) => SizedBox(height: 35),
                      itemCount: lines.length + 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
