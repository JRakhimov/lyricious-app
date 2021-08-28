import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lyricious/src/core/router/app_router.gr.dart';
import 'package:lyricious/src/domain/models/models.dart';
import 'package:lyricious/src/domain/repositories/repositories.dart';
import 'package:lyricious/src/presentation/components/components.dart';
import 'package:lyricious/src/presentation/theme/colors.dart';

class HomeRecentlySection extends StatelessWidget {
  Widget _likedText(Box<HiveSongModel> box) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "Recently",
                style: TextStyle(
                  fontFamily: "Gilroy",
                  color: AppColors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (box.length > 0) SizedBox(width: 10),
              if (box.length > 0)
                Text(
                  "${box.length} songs",
                  style: TextStyle(
                    fontFamily: "Gilroy",
                    color: AppColors.greyBD,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
          if (box.length > 0)
            InkWell(
              child: Text(
                "Clear",
                style: TextStyle(
                  fontFamily: "Gilroy",
                  color: AppColors.black.withOpacity(0.5),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              onTap: () => MemoryRepository.clearRecently(),
              onLongPress: () => MemoryRepository.clearLiked(),
            )
        ],
      ),
    );
  }

  Widget _song(BuildContext context, SongModel song) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: () => AutoRouter.of(context).push(LyricsRoute(song: song, lyrics: song.lyrics)),
        child: SongTile(song: song, showMenuButton: true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: MemoryRepository.recentlyBox().listenable(),
      builder: (BuildContext context, Box<HiveSongModel> box, Widget? child) {
        final values = box.values.toList()..sort((a, b) => b.actionDate.compareTo(a.actionDate));

        return Column(
          children: [
            _likedText(box),
            for (final hiveSong in values) _song(context, hiveSong.song),
          ],
        );
      },
    );
  }
}
