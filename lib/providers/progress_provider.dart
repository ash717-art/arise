import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/player_progress.dart';
import 'package:myapp/models/quest_model.dart';
import 'package:myapp/services/progress_store.dart';

final progressStoreProvider = Provider<ProgressStore>((ref) => ProgressStore());

final playerProgressProvider =
    StateNotifierProvider<PlayerProgressNotifier, AsyncValue<PlayerProgress>>((ref) {
  final store = ref.watch(progressStoreProvider);
  return PlayerProgressNotifier(store)..init();
});

class PlayerProgressNotifier extends StateNotifier<AsyncValue<PlayerProgress>> {
  final ProgressStore _store;

  PlayerProgressNotifier(this._store) : super(const AsyncValue.loading());

  Future<void> init() async {
    try {
      final p = await _store.load();
      state = AsyncValue.data(p);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> completeQuest(Quest quest) async {
    final current = state.valueOrNull;
    if (current == null) return;

    if (current.questsCompleted >= PlayerProgress.totalProgramQuests) return;

    final xp = quest.xpReward;
    var totalXp = current.totalXp + xp;
    var xpInto = current.xpIntoLevel + xp;
    var level = current.level;

    while (xpInto >= PlayerProgress.xpPerLevel) {
      xpInto -= PlayerProgress.xpPerLevel;
      level += 1;
    }

    final updated = current.copyWith(
      totalXp: totalXp,
      xpIntoLevel: xpInto,
      level: level,
      questsCompleted: (current.questsCompleted + 1).clamp(0, PlayerProgress.totalProgramQuests),
    );

    state = AsyncValue.data(updated);
    await _store.save(updated);
  }

  Future<void> setPlayerName(String name) async {
    final current = state.valueOrNull;
    if (current == null) return;

    final trimmed = name.trim();
    if (trimmed.isEmpty) return;

    final updated = current.copyWith(playerName: trimmed.toUpperCase());
    state = AsyncValue.data(updated);
    await _store.save(updated);
  }

  Future<void> resetProgress() async {
    await _store.reset();
    state = const AsyncValue.loading();
    await init();
  }
}
