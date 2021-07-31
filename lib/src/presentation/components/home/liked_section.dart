import 'package:flutter/material.dart';
import 'package:lyricious/src/presentation/theme/colors.dart';

class HomeLikedSection extends StatelessWidget {
  Widget _likedText() {
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
          SizedBox(width: 10),
          Text(
            "6 songs",
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

  // Widget _song(BuildContext context, LyricsModel lyrics) {
  //   return Padding(
  //     padding: EdgeInsets.only(bottom: 20),
  //     child: InkWell(
  //       onTap: () => AutoRouter.of(context).push(LyricsRoute(lyrics: lyrics)),
  //       child: SongTile(song: lyrics.song),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _likedText(),
      ],
    );
  }
}
