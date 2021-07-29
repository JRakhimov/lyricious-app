part of 'home_page_cubit.dart';

@freezed
abstract class HomePageState with _$HomePageState {
  const factory HomePageState({
    @Default(0) int currentTabOption,
  }) = _HomePageState;
}
