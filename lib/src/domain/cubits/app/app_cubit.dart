import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spotify_sdk/models/connection_status.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

part 'app_cubit.freezed.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState());

  late Stream<ConnectionStatus> connectionStatus;
  late Stream<PlayerState> playerStatus;

  void initCubit() async {
    try {
      await SpotifySdk.getLibraryState(
        spotifyUri: "https://open.spotify.com/track/6gMKBgWDe6bkO6iSimuUC8?si=9a2e40b69d674fef",
      );

      await this.fetchPlayerStatus();
    } catch (e) {
      final isDisconnected = e.toString().contains("SpotifyDisconnectedException");

      emit(state.copyWith(isSpotifyConnected: !isDisconnected));
    }

    connectionStatus = SpotifySdk.subscribeConnectionStatus()..listen(connectionStatusListener);
    playerStatus = SpotifySdk.subscribePlayerState()..listen(playerStatusListener);
  }

  void connectionStatusListener(ConnectionStatus status) {
    print('Connection status: ${status.connected}');
    emit(state.copyWith(isSpotifyConnected: status.connected));
  }

  void playerStatusListener(PlayerState status) {
    emit(state.copyWith(spotifyPlayerStatus: status));
  }

  Future<void> fetchPlayerStatus() async {
    final status = await SpotifySdk.getPlayerState();

    emit(state.copyWith(spotifyPlayerStatus: status));
  }

  Future<bool> connectSpotify() async {
    final status = await SpotifySdk.connectToSpotifyRemote(
      clientId: dotenv.env["SPOTIFY_CLIENT_ID"]!,
      redirectUrl: dotenv.env["SPOTIFY_REDIRECT_URL"]!,
    );

    if (state.isSpotifyConnected != status) emit(state.copyWith(isSpotifyConnected: status));

    return status;
  }
}
