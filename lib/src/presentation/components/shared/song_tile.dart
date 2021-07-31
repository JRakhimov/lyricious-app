import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:lyricious/src/domain/models/models.dart';
import 'package:lyricious/src/domain/repositories/memory_repository.dart';
import 'package:lyricious/src/presentation/icons/app_icons.dart';
import 'package:lyricious/src/presentation/theme/colors.dart';

class SongTile extends StatelessWidget {
  SongModel song;
  Color? albumColor;
  bool isLight;
  bool showLikeButton;
  bool showMenuButton;

  SongTile({
    required this.song,
    this.albumColor,
    this.isLight = false,
    this.showLikeButton = false,
    this.showMenuButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final circle = Container(
      width: 7.5,
      height: 7.5,
      decoration: BoxDecoration(
        color: isLight ? AppColors.white : AppColors.black,
        borderRadius: BorderRadius.circular(50),
      ),
    );

    final albumPicStock = Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: albumColor ?? AppColors.getRandomColor(),
        borderRadius: BorderRadius.circular(12.5),
      ),
      child: Center(
        child: Text(
          song.name[0],
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (song.albumPic != null)
          Container(
            width: 60,
            height: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.5),
              child: CachedNetworkImage(
                imageUrl: song.albumPic!,
                placeholder: (_, __) => albumPicStock,
                errorWidget: (_, __, ___) => albumPicStock,
              ),
            ),
          )
        else
          albumPicStock,
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                song.name,
                style: TextStyle(
                  color: isLight ? AppColors.white : AppColors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Gilroy",
                ),
              ),
              SizedBox(height: 2.5),
              Text(
                song.artists[0],
                style: TextStyle(
                  color: isLight ? AppColors.white : AppColors.black,
                  fontSize: 15,
                  fontFamily: "Gilroy",
                ),
              ),
            ],
          ),
        ),
        if (showLikeButton)
          LikeButton(
            size: 30,
            circleColor: CircleColor(start: AppColors.violet, end: AppColors.red),
            bubblesColor: BubblesColor(
              dotPrimaryColor: AppColors.red,
              dotSecondaryColor: AppColors.yellow,
            ),
            isLiked: MemoryRepository.getFromLiked(MemoryRepository.generateSongKey(song)) != null,
            likeBuilder: (bool isLiked) {
              return Icon(
                AppIcons.heart,
                color: isLiked ? AppColors.red : Colors.grey,
                size: 30,
              );
            },
            onTap: (_) async {
              if (MemoryRepository.getFromLiked(MemoryRepository.generateSongKey(song)) != null) {
                MemoryRepository.removeFromLiked(song);
                return false;
              }

              MemoryRepository.putToLiked(song);
              return true;
            },
          ),
        if (showLikeButton && showMenuButton) SizedBox(width: 10),
        if (showMenuButton) Row(children: [circle, SizedBox(width: 10), circle])
      ],
    );
  }
}
