
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Dotenv {
  static void load() async {
    await dotenv.load();
  }

  static String apiKey() {
    return dotenv.env['API_KEY'] ?? '';
  }
}