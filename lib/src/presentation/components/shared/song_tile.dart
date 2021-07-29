import 'package:flutter/material.dart';
import 'package:lyricious/src/domain/models/models.dart';
import 'package:lyricious/src/presentation/theme/colors.dart';

class SongTile extends StatelessWidget {
  SongModel song;
  Color? albumColor;
  bool isLight;

  SongTile({
    required this.song,
    this.albumColor,
    this.isLight = false,
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
              child: Image(
                image: NetworkImage(song.albumPic!),
                errorBuilder: (context, _, __) => albumPicStock,
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
                song.artist,
                style: TextStyle(
                  color: isLight ? AppColors.white : AppColors.black,
                  fontSize: 15,
                  fontFamily: "Gilroy",
                ),
              ),
            ],
          ),
        ),
        Row(children: [circle, SizedBox(width: 10), circle])
      ],
    );
  }
}
