# WirdiApp — وِردي 📖

Flutter app for **Qur'an study associations**: supervisors organise study circles,
assign **memorization (حفظ)** and **revision (مراجعة)** programmes, schedule **exams**
and follow every student's progress; students follow their daily *wird* from their phone.

Arabic, right-to-left interface — works offline, no account or server to set up.

## Features

**Supervisor space** (protected by a 4-digit PIN)
- Dashboard: average progress, number of students and circles, upcoming exams,
  programmes falling behind schedule.
- Study circles (حلقات): create, rename, delete, filter students by circle.
- Students: add / edit / delete, search, per-student page with progress ring,
  programmes and exams; a 6-digit **access code** is generated for each student.
- Programmes: memorization or revision, number of pages, deadline, notes,
  quick ⊕ / ⊖ progress buttons, automatic "late" and "completed" badges.
- Exams: scheduling, editing, result out of 20 (≥ 10 = passed).
- Activity feed: new programmes, completed programmes, exam results.

**Student space** (e-mail + access code)
- Personal dashboard with overall progress and next exam.
- Memorization and revision programmes — the student marks each page done.
- Exam schedule and results, personal notifications.

**Other**
- Optional fictional demo data to explore the app in one tap.
- Data reset, logout.

## Architecture

```
lib/
├── data/
│   ├── models.dart            Group, Student, Program, Exam, AppEvent, Association (+ JSON)
│   ├── wird_repository.dart   WirdRepository interface · Local (device) · Memory (tests)
│   └── demo_data.dart         fictional sample data
├── state/app_state.dart       ChangeNotifier: session, queries, use cases, persistence
└── ui/
    ├── theme.dart · widgets.dart       design system (colours, cards, progress, pills…)
    ├── auth/        welcome, association setup, supervisor PIN, student login
    ├── supervisor/  dashboard shell, students, circles, programmes, exams, forms
    ├── student/     student shell
    └── common/      notifications, settings
```

- **State management**: `provider` + a single `AppState`; screens only read state and call use cases.
- **Dependency inversion**: `AppState` depends on the `WirdRepository` interface — the local
  storage can be swapped for Firestore (multi-device sync) without touching the UI.
- **Tests**: models and use cases (login, progress, results, cascading delete) run
  against the in-memory repository.

## Run

```bash
flutter pub get
flutter run
flutter test
```

First launch: open **فضاء المشرف**, create the association and a PIN (tick
*بيانات تجريبية* to load demo data). Demo student login: `amna@example.com` / `204816`.

## What changed in v2

The first version was a static prototype: hard-coded lists (with real people's
names and phone numbers), login screens that did not check anything, no data
saved, and file imports that broke the build on Linux/macOS. Version 2 is a
complete, working app with persistence, real roles, validation, tests and CI.

## Tech

Flutter · Dart 3 · Material 3 · provider · shared_preferences · RTL / Arabic localisation
