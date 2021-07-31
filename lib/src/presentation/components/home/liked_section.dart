import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lyricious/src/core/router/app_router.gr.dart';
import 'package:lyricious/src/domain/models/models.dart';
import 'package:lyricious/src/domain/repositories/repositories.dart';
import 'package:lyricious/src/presentation/components/components.dart';
import 'package:lyricious/src/presentation/theme/colors.dart';

class HomeLikedSection extends StatelessWidget {
  Widget _likedText(Box<SongModel> box) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Liked",
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
      valueListenable: MemoryRepository.likedBox().listenable(),
      builder: (BuildContext context, Box<SongModel> box, Widget? child) {
        return Column(
          children: [
            _likedText(box),
            for (final song in box.values) _song(context, song),
          ],
        );
      },
    );
  }
}
