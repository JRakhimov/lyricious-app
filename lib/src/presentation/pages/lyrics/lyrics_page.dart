import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lyricious/src/core/utils/extensions.dart';
import 'package:lyricious/src/domain/cubits/cubits.dart';
import 'package:lyricious/src/domain/models/models.dart';
import 'package:lyricious/src/domain/repositories/lyrics_repository.dart';
import 'package:lyricious/src/domain/repositories/memory_repository.dart';
import 'package:lyricious/src/presentation/components/shared/music_wave.dart';
import 'package:lyricious/src/presentation/components/shared/song_tile.dart';
import 'package:lyricious/src/presentation/components/shimmers/lyrics_page_shimmer.dart';
import 'package:lyricious/src/presentation/theme/colors.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:wakelock/wakelock.dart';

class LyricsPage extends StatefulWidget {
  LyricsModel? lyrics;
  SongModel song;

  LyricsPage({this.lyrics, required this.song});

  @override
  _LyricsPageState createState() => _LyricsPageState();
}

class _LyricsPageState extends State<LyricsPage> with TickerProviderStateMixin {
  ItemScrollController _itemScrollController = ItemScrollController();
  ScrollController _scrollController = ScrollController();
  bool scroll = false;
  int speedFactor = 20;

  late Color color;
  LyricsModel? lyrics;

  int _currentLineIndex = 0;
  int _milliseconds = 0;
  Timer? timer;

  void lyricsFound(LyricsModel lyrics) async {
    if (!lyrics.withTimeCode || !inject<AppCubit>().state.isSpotifyConnected) {
      Future.delayed(Duration(seconds: 1)).then((value) => _toggleScrolling());
      return;
    }

    final playerState = await SpotifySdk.getPlayerState();

    // playerState?.isPaused == true ||
    // if (playerState?.track == null) {
    //   Future.delayed(Duration(seconds: 1)).then((value) => _toggleScrolling());
    //   return;
    // }

    // if (playerState!.track!.name != widget.song.name) {
    //   Future.delayed(Duration(seconds: 1)).then((value) => _toggleScrolling());
    //   return;
    // }

    timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      _milliseconds += 50;

      if (_milliseconds >= lyrics.lines[_currentLineIndex].startTime! * 1000) {
        setState(() => _currentLineIndex += 1);

        if (_itemScrollController.isAttached)
          _itemScrollController.scrollTo(index: _currentLineIndex, duration: Duration(milliseconds: 200));
      }

      if (_milliseconds > lyrics.lines.last.startTime! * 1000) timer.cancel();
    });
  }

  @override
  void initState() {
    super.initState();
    Wakelock.enable();

    color = AppColors.getRandomColor();

    if (widget.lyrics != null) {
      lyrics = widget.lyrics;

      lyricsFound(widget.lyrics!);
      return;
    }

    final key = MemoryRepository.generateSongKey(widget.song);
    final hiveSong = MemoryRepository.getFromLiked(key) ?? MemoryRepository.getFromRecently(key);

    if (hiveSong != null) {
      if (hiveSong.song.lyrics != null && hiveSong.song.lyrics!.lines.isNotEmpty) {
        lyrics = hiveSong.song.lyrics;

        lyricsFound(hiveSong.song.lyrics!);
      }

      return;
    }

    LyricsRepository.getLyrics(
      name: widget.song.name,
      artist: widget.song.artists[0],
      duration: widget.song.duration,
    ).then((value) {
      setState(() {
        lyrics = value;

        if (value.lines.isNotEmpty) {
          widget.song.lyrics = lyrics;
          MemoryRepository.putToRecently(widget.song);

          lyricsFound(value);
        }
      });
    });
  }

  @override
  void dispose() {
    inject<AppCubit>().fetchPlayerStatus();

    _scrollController.dispose();
    timer?.cancel();
    Wakelock.disable();
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
      _scrollController.animateTo(
        _scrollController.offset,
        duration: Duration(milliseconds: 1500),
        curve: Curves.linear,
      );
    }
  }

  _onLineTap(int index) {
    final currentLine = lyrics!.lines[index - 2];
    final nextLine = lyrics!.lines[index >= lyrics!.lines.length ? index - 2 : index - 1];
    final difference = (nextLine.startTime! - currentLine.startTime!) * 1000;

    setState(() {
      _currentLineIndex = index - 2;
      _milliseconds = (currentLine.startTime! * 1000 - difference).toInt();
    });

    _itemScrollController.scrollTo(index: _currentLineIndex, duration: Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    if (lyrics == null) {
      return Scaffold(
        backgroundColor: AppColors.black,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: LyricsPageShimmer(),
        ),
      );
    }

    final lines = lyrics!.lines;

    IndexedWidgetBuilder itemBuilder = (context, i) {
      if ([0, 1].contains(i)) return SizedBox();

      final live = lyrics!.withTimeCode && timer != null;

      return InkWell(
        onTap: () => _onLineTap(i),
        child: Text(
          lines[i - 2].text,
          style: TextStyle(
            fontSize: 28,
            fontFamily: "Gilroy",
            fontWeight: FontWeight.w700,
            color: live
                ? _currentLineIndex == i - 2
                    ? AppColors.black
                    : AppColors.white.withOpacity(0.65)
                : AppColors.white,
          ),
        ),
      );
    };

    IndexedWidgetBuilder separatorBuilder = (context, i) => SizedBox(height: 35);

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SafeArea(
              child: SongTile(
                song: widget.song,
                albumColor: color,
                isLight: true,
                showSpotifyIcon: true,
                showLikeButton: lyrics != null && lyrics!.lines.isNotEmpty,
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: lines.length > 0
                    ? Container(
                        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(30)),
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                        child: NotificationListener(
                          onNotification: (notif) {
                            if (notif is ScrollEndNotification && scroll) {
                              Timer(Duration(seconds: 1), () => _scroll());
                            }

                            return true;
                          },
                          child: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: <Color>[
                                  color,
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.transparent,
                                  color
                                ],
                              ).createShader(bounds);
                            },
                            blendMode: BlendMode.dstOut,
                            child: lyrics!.withTimeCode && timer != null
                                ? ScrollablePositionedList.separated(
                                    itemScrollController: _itemScrollController,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: itemBuilder,
                                    separatorBuilder: separatorBuilder,
                                    itemCount: lines.length + 2,
                                  )
                                : ListView.separated(
                                    controller: _scrollController,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: itemBuilder,
                                    separatorBuilder: separatorBuilder,
                                    itemCount: lines.length + 2,
                                  ),
                          ),
                        ),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(height: 100, child: MusicVisualizerColorful()),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                "We couldn't find the lyrics for this song, but you have great taste :)",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Gilroy",
                                ),
                              ),
                            ),
                          ],
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
