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

  int currentLineIndex = 0;
  int milliseconds = 0;
  Timer? timer;

  void lyricsFound(LyricsModel lyrics) async {
    if (!lyrics.withTimeCode || !inject<AppCubit>().state.isSpotifyConnected) {
      Future.delayed(Duration(seconds: 1)).then((value) => _toggleScrolling());
      return;
    }

    final playerState = await SpotifySdk.getPlayerState();

    if (playerState?.isPaused == true || playerState?.track == null) return;
    // if (playerState!.track!.name != widget.song.name) return;

    timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      milliseconds += 50;

      if (milliseconds >= lyrics.lines[currentLineIndex].startTime! * 1000) {
        print(lyrics.lines[currentLineIndex].text);
        print(lyrics.lines[currentLineIndex].startTime);

        // setState(() {
        currentLineIndex += 1;
        // });

        _itemScrollController.scrollTo(index: currentLineIndex, duration: Duration(milliseconds: 200));
      }

      if (milliseconds > lyrics.lines.last.startTime! * 1000) timer.cancel();
    });
  }

  @override
  void initState() {
    super.initState();

    color = AppColors.getRandomColor();

    if (widget.lyrics != null) {
      lyrics = widget.lyrics;

      lyricsFound(widget.lyrics!);
      return;
    }

    final key = MemoryRepository.generateSongKey(widget.song);
    final song = MemoryRepository.getFromLiked(key) ?? MemoryRepository.getFromRecently(key);

    if (song != null) {
      if (song.lyrics != null && song.lyrics!.lines.isNotEmpty) {
        lyrics = song.lyrics;

        lyricsFound(song.lyrics!);
      }

      return;
    }

    LyricsRepository.getLyrics(name: widget.song.name, artist: widget.song.artists[0]).then((value) {
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
      final style = TextStyle(
        fontSize: 28,
        fontFamily: "Gilroy",
        fontWeight: FontWeight.w700,
      );

      if (i == 0) return Text("Source: ${lyrics!.service}", style: style);

      return Text(lines[i - 1].text, style: style);
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
                showLikeButton: true,
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
                            child: lyrics!.withTimeCode
                                ? ScrollablePositionedList.separated(
                                    itemScrollController: _itemScrollController,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: itemBuilder,
                                    separatorBuilder: separatorBuilder,
                                    itemCount: lines.length + 1,
                                  )
                                : ListView.separated(
                                    controller: _scrollController,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: itemBuilder,
                                    separatorBuilder: separatorBuilder,
                                    itemCount: lines.length + 1,
                                  ),
                          ),
                        ),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 100,
                              child: MusicVisualizerColorful(),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                "We didn't find the lyrics for this song, but you have great taste :)",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: "Gilroy"),
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
