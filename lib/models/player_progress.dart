import 'dart:convert';

class PlayerProgress {
  final DateTime startDate; // 90-day program start
  final int questsCompleted; // 0..90
  final int totalXp; // lifetime xp
  final int xpIntoLevel; // 0..xpPerLevel-1
  final int level; // starts at 1
  final String playerName; // display name

  const PlayerProgress({
    required this.startDate,
    required this.questsCompleted,
    required this.totalXp,
    required this.xpIntoLevel,
    required this.level,
    required this.playerName,
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
  }) {
    return PlayerProgress(
      startDate: startDate ?? this.startDate,
      questsCompleted: questsCompleted ?? this.questsCompleted,
      totalXp: totalXp ?? this.totalXp,
      xpIntoLevel: xpIntoLevel ?? this.xpIntoLevel,
      level: level ?? this.level,
      playerName: playerName ?? this.playerName,
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
      };

  static PlayerProgress fromJson(Map<String, dynamic> json) {
    return PlayerProgress(
      startDate: DateTime.tryParse(json['startDate'] ?? '') ?? DateTime.now(),
      questsCompleted: (json['questsCompleted'] ?? 0) as int,
      totalXp: (json['totalXp'] ?? 0) as int,
      xpIntoLevel: (json['xpIntoLevel'] ?? 0) as int,
      level: (json['level'] ?? 1) as int,
      playerName: (json['playerName'] ?? 'PLAYER ONE') as String,
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
      );
    }
    return fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  String toStorage() => jsonEncode(toJson());
}
