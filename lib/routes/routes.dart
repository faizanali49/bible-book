
import 'package:bible/views/chapter_view.dart';
import 'package:bible/views/home_view.dart';
import 'package:bible/views/verse_view.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: "/", builder: (context, state) => const HomeScreen()),
    GoRoute(
      name: "chapter",
      path: "/chapter",
      builder: (context, state) => ChapterView()
    ),
    GoRoute(
      // name: "verse",
      path: "/verse/:chapter/:verse",
      builder: (context, state) {
        final chapter = state.pathParameters['chapter']!;
        final verse = state.pathParameters['verse']!;
        return VerseView(chapterNo: chapter, verseNo: verse);
      },
    ),
  ],
);
