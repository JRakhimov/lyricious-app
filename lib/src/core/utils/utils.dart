import 'package:flutter_dotenv/flutter_dotenv.dart';

void checkEnvVariables() {
  final requiredVariables = ["SPOTIFY_CLIENT_ID", "SPOTIFY_REDIRECT_URL", "LYRICS_HOST"];

  for (final variable in requiredVariables) {
    if (dotenv.env[variable] == null) {
      throw Exception("env variable $variable is not defined");
    }
  }
}
