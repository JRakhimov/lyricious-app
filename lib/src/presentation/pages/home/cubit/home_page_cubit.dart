import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lyricious/src/presentation/components/components.dart';
import 'package:lyricious/src/presentation/components/home/recently_section.dart';

part 'home_page_cubit.freezed.dart';
part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageState());

  List<TabOption> tabOptions = [
    TabOption(title: "Liked", bodyBuilder: () => HomeLikedSection()),
    TabOption(title: "Recently", bodyBuilder: () => HomeRecentlySection()),
    TabOption(title: "Top", bodyBuilder: () => Container()),
    TabOption(title: "Playlist", bodyBuilder: () => Container()),
  ];

  void setTabOption(int index) => emit(state.copyWith(currentTabOption: index));
}
