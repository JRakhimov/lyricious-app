import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyricious/src/core/router/app_router.gr.dart';
import 'package:lyricious/src/core/utils/extensions.dart';
import 'package:lyricious/src/domain/cubits/app/app_cubit.dart';
import 'package:lyricious/src/domain/models/models.dart';
import 'package:lyricious/src/presentation/components/shared/music_wave.dart';
import 'package:lyricious/src/presentation/theme/colors.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class _Header extends StatefulWidget {
  @override
  __HeaderState createState() => __HeaderState();
}

class __HeaderState extends State<_Header> {
  bool isLoading = false;

  Widget spotifyStatus(AppState state) {
    final style = TextStyle(fontWeight: FontWeight.w600, fontFamily: "Gilroy");

    if (isLoading) return Text("Connecting", style: style);

    if (!state.isSpotifyConnected) return Text("Connect your Spotify account", style: style);

    if (state.spotifyPlayerStatus != null) {
      if (state.spotifyPlayerStatus!.isPaused) return Text("Spotify paused", style: style);

      if (state.spotifyPlayerStatus?.track != null)
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(height: 20, child: MusicVisualizer()),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  [
                    state.spotifyPlayerStatus!.track!.artist.name,
                    state.spotifyPlayerStatus!.track!.name,
                  ].join(" - "),
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: style,
                ),
              ),
            ],
          ),
        );
    }

    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        final cubit = getCubit<AppCubit>(context);

        return Stack(
          fit: StackFit.expand,
          children: [
            Container(color: AppColors.primary),
            Center(
              child: Text(
                "Lyricious",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  fontFamily: "Comfortaa",
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  child: spotifyStatus(state),
                  onTap: state.isSpotifyConnected
                      ? () async {
                          if (state.spotifyPlayerStatus?.track == null) return;

                          final urlSplitted = state.spotifyPlayerStatus!.track!.imageUri.raw.split(":");

                          AutoRouter.of(context).push(
                            LyricsRoute(
                              song: SongModel(
                                artists: [state.spotifyPlayerStatus!.track!.artist.name],
                                name: state.spotifyPlayerStatus!.track!.name,
                                albumPic: "https://i.scdn.co/image/${urlSplitted.last}",
                              ),
                            ),
                          );
                        }
                      : () async {
                          setState(() => isLoading = true);
                          await cubit.connectSpotify();
                          setState(() => isLoading = false);
                        },
                  onLongPress: () => SpotifySdk.disconnect(),
                ),
              ),
              bottom: 10,
            ),
          ],
        );
      },
    );
  }
}

class HomePageHeader implements SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final radius = shrinkOffset == 0
        ? 30
        : shrinkOffset >= 90
            ? 0
            : 30 - (shrinkOffset * 30 / 90);

    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(radius.toDouble()),
        bottomRight: Radius.circular(radius.toDouble()),
      ),
      child: _Header(),
    );
  }

  @override
  double get maxExtent => 250;

  @override
  double get minExtent => 150;

  @override
  TickerProvider? get vsync => null;

  @override
  FloatingHeaderSnapConfiguration? get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration? get stretchConfiguration => null;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;

  @override
  PersistentHeaderShowOnScreenConfiguration? get showOnScreenConfiguration => null;
}
