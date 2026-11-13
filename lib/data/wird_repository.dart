import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wirdi_app/data/models.dart';

/// Snapshot of everything the app stores.
class WirdData {
  const WirdData({
    this.association,
    this.groups = const [],
    this.students = const [],
    this.programs = const [],
    this.exams = const [],
    this.events = const [],
  });

  final Association? association;
  final List<Group> groups;
  final List<Student> students;
  final List<Program> programs;
  final List<Exam> exams;
  final List<AppEvent> events;
}

/// Persistence abstraction: the UI and the state never know where data lives.
/// A Firestore implementation can replace [LocalWirdRepository] without
/// touching any screen (dependency inversion).
abstract class WirdRepository {
  Future<WirdData> load();
  Future<void> save(WirdData data);
  Future<void> clear();
}

/// Stores the data as JSON on the device (works offline, no setup needed).
class LocalWirdRepository implements WirdRepository {
  static const _key = 'wirdi_data_v1';

  @override
  Future<WirdData> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return const WirdData();
    final j = jsonDecode(raw) as Map<String, dynamic>;
    List<T> list<T>(String key, T Function(Map<String, dynamic>) fromJson) =>
        ((j[key] as List?) ?? const []).map((e) => fromJson(e as Map<String, dynamic>)).toList();
    return WirdData(
      association: j['association'] == null ? null : Association.fromJson(j['association'] as Map<String, dynamic>),
      groups: list('groups', Group.fromJson),
      students: list('students', Student.fromJson),
      programs: list('programs', Program.fromJson),
      exams: list('exams', Exam.fromJson),
      events: list('events', AppEvent.fromJson),
    );
  }

  @override
  Future<void> save(WirdData data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _key,
      jsonEncode({
        'association': data.association?.toJson(),
        'groups': data.groups.map((e) => e.toJson()).toList(),
        'students': data.students.map((e) => e.toJson()).toList(),
        'programs': data.programs.map((e) => e.toJson()).toList(),
        'exams': data.exams.map((e) => e.toJson()).toList(),
        'events': data.events.map((e) => e.toJson()).toList(),
      }),
    );
  }

  @override
  Future<void> clear() async => (await SharedPreferences.getInstance()).remove(_key);
}

/// In-memory implementation, used by the tests.
class MemoryWirdRepository implements WirdRepository {
  WirdData _data = const WirdData();

  @override
  Future<WirdData> load() async => _data;

  @override
  Future<void> save(WirdData data) async => _data = data;

  @override
  Future<void> clear() async => _data = const WirdData();
}
