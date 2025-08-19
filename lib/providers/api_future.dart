import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final bookWhich = StateProvider<String>((ref) => 'Exodus');

final bibleVersesProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) async {
  List<Map<String, dynamic>> chapters = [];
  int chapter = 1;
  final selectedBook = ref.watch(bookWhich).replaceAll(' ', '');
  while (true) {
    debugPrint(selectedBook);
    final url = Uri.parse(
      "https://cdn.jsdelivr.net/gh/wldeh/bible-api/bibles/en-asv/books/$selectedBook/chapters/$chapter.json",
    );
    debugPrint(url.toString());

    final response = await http.get(url);
    if (response.statusCode == 200) {
      try {
        final data = json.decode(response.body);
        if (data is Map<String, dynamic>) {
          chapters.add(data);
          chapter++;
        } else {
          break; // not JSON we expect
        }
        debugPrint('fetching chapter $chapter');
      } catch (e) {
        debugPrint(e.toString());
        break; // invalid JSON
      }
    } else {
      print('nothing found');
      break; // stop if 404 or error
    }
  }
  return chapters;
});
