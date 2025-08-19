import 'dart:convert';
import 'package:bible/providers/api_future.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ChapterLoadState {
  final List<Map<String, dynamic>> chapters;
  final double progress; // 0.0 to 1.0
  final bool isLoading;
  final String? error;

  ChapterLoadState({
    required this.chapters,
    required this.progress,
    required this.isLoading,
    this.error,
  });

  ChapterLoadState copyWith({
    List<Map<String, dynamic>>? chapters,
    double? progress,
    bool? isLoading,
    String? error,
  }) {
    return ChapterLoadState(
      chapters: chapters ?? this.chapters,
      progress: progress ?? this.progress,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ChapterLoader extends StateNotifier<ChapterLoadState> {
  ChapterLoader(this.ref) : super(ChapterLoadState(chapters: [], progress: 0, isLoading: false));
  final Ref ref;

  Future<void> loadChapters() async {
    state = state.copyWith(isLoading: true, progress: 0, chapters: [], error: null);
    List<Map<String, dynamic>> chapters = [];
    int chapter = 1;
    final selectedBook = ref.read(bookWhich).replaceAll(' ', '');

    // First, get total chapters (you may need to adjust this if your API provides it)
    int totalChapters = 50; // <-- Set a reasonable max or fetch from API if possible

    while (true) {
      final url = Uri.parse(
        "https://cdn.jsdelivr.net/gh/wldeh/bible-api/bibles/en-asv/books/$selectedBook/chapters/$chapter.json",
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        try {
          final data = json.decode(response.body);
          if (data is Map<String, dynamic>) {
            chapters.add(data);
            chapter++;
            // Update progress
            double progress = chapter / totalChapters;
            if (progress > 1.0) progress = 1.0;
            state = state.copyWith(
              chapters: List.from(chapters),
              progress: progress,
              isLoading: true,
            );
          } else {
            break;
          }
        } catch (e) {
          state = state.copyWith(isLoading: false, error: e.toString());
          break;
        }
      } else {
        break;
      }
    }
    state = state.copyWith(isLoading: false, chapters: chapters, progress: 1.0);
  }
}

final chapterLoaderProvider = StateNotifierProvider<ChapterLoader, ChapterLoadState>(
  (ref) => ChapterLoader(ref),
);