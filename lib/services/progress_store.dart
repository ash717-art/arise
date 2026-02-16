import 'package:shared_preferences/shared_preferences.dart';
import 'package:myapp/models/player_progress.dart';

class ProgressStore {
  static const _key = 'player_progress_v1';

  Future<PlayerProgress> load() async {
    final prefs = await SharedPreferences.getInstance();
    return PlayerProgress.fromStorage(prefs.getString(_key));
  }

  Future<void> save(PlayerProgress progress) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, progress.toStorage());
  }

  Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
