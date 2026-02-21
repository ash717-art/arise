import 'dart:convert';

class PlayerProgress {
  final DateTime startDate; // 90-day program start
  final int questsCompleted; // 0..90
  final int totalXp; // lifetime xp
  final int xpIntoLevel; // 0..xpPerLevel-1
  final int level; // starts at 1
  final String playerName; // display name
  final int currentStreak;
  final int highestStreak;
  final DateTime? lastQuestCompletionDate;

  const PlayerProgress({
    required this.startDate,
    required this.questsCompleted,
    required this.totalXp,
    required this.xpIntoLevel,
    required this.level,
    required this.playerName,
    this.currentStreak = 0,
    this.highestStreak = 0,
    this.lastQuestCompletionDate,
  });

  static const int xpPerLevel = 500;
  static const int totalProgramQuests = 90;

  PlayerProgress copyWith({
    DateTime? startDate,
    int? questsCompleted,
    int? totalXp,
    int? xpIntoLevel,
    int? level,
    String? playerName,
    int? currentStreak,
    int? highestStreak,
    DateTime? lastQuestCompletionDate,
  }) {
    return PlayerProgress(
      startDate: startDate ?? this.startDate,
      questsCompleted: questsCompleted ?? this.questsCompleted,
      totalXp: totalXp ?? this.totalXp,
      xpIntoLevel: xpIntoLevel ?? this.xpIntoLevel,
      level: level ?? this.level,
      playerName: playerName ?? this.playerName,
      currentStreak: currentStreak ?? this.currentStreak,
      highestStreak: highestStreak ?? this.highestStreak,
      lastQuestCompletionDate:
          lastQuestCompletionDate ?? this.lastQuestCompletionDate,
    );
  }

  double get levelProgress => xpIntoLevel / xpPerLevel;

  /// Rank strictly tied to 90-day completion.
  /// S is ONLY unlocked when questsCompleted == 90.
  String get rank {
    if (questsCompleted >= totalProgramQuests) return 'S';
    final p = questsCompleted / totalProgramQuests; // 0..1
    if (p >= 0.80) return 'A';
    if (p >= 0.60) return 'B';
    if (p >= 0.40) return 'C';
    if (p >= 0.20) return 'D';
    return 'E';
  }

  int get daysIntoProgram {
    final now = DateTime.now();
    final start = DateTime(startDate.year, startDate.month, startDate.day);
    final today = DateTime(now.year, now.month, now.day);
    return today.difference(start).inDays.clamp(0, totalProgramQuests);
  }

  Map<String, dynamic> toJson() => {
    'startDate': startDate.toIso8601String(),
    'questsCompleted': questsCompleted,
    'totalXp': totalXp,
    'xpIntoLevel': xpIntoLevel,
    'level': level,
    'playerName': playerName,
    'currentStreak': currentStreak,
    'highestStreak': highestStreak,
    'lastQuestCompletionDate': lastQuestCompletionDate?.toIso8601String(),
  };

  static PlayerProgress fromJson(Map<String, dynamic> json) {
    return PlayerProgress(
      startDate: DateTime.tryParse(json['startDate'] ?? '') ?? DateTime.now(),
      questsCompleted: (json['questsCompleted'] ?? 0) as int,
      totalXp: (json['totalXp'] ?? 0) as int,
      xpIntoLevel: (json['xpIntoLevel'] ?? 0) as int,
      level: (json['level'] ?? 1) as int,
      playerName: (json['playerName'] ?? 'PLAYER ONE') as String,
      currentStreak: (json['currentStreak'] ?? 0) as int,
      highestStreak: (json['highestStreak'] ?? 0) as int,
      lastQuestCompletionDate:
          DateTime.tryParse(json['lastQuestCompletionDate'] ?? ''),
    );
  }

  static PlayerProgress fromStorage(String? raw) {
    if (raw == null || raw.isEmpty) {
      return PlayerProgress(
        startDate: DateTime.now(),
        questsCompleted: 0,
        totalXp: 0,
        xpIntoLevel: 0,
        level: 1,
        playerName: 'PLAYER ONE',
        currentStreak: 0,
        highestStreak: 0,
        lastQuestCompletionDate: null,
      );
    }
    return fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  String toStorage() => jsonEncode(toJson());
}
