import 'package:bible/providers/api_future.dart';
import 'package:bible/providers/theme.dart';
import 'package:bible/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerseView extends ConsumerWidget {
  final String verseNo;
  final String chapterNo;
  const VerseView({super.key, required this.verseNo, required this.chapterNo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeIsDark);
    final appColor = AppColor(isDarkMode: isDark);
    final verses = ref.watch(bibleVersesProvider);
    final fontSize = ref.watch(fontChanger);
    // final expand = ref.watch(isExpanded);
    // print(verseNo);
    // print(chapterNo);
    int chapter_index = int.parse(chapterNo);
    int verse_index = int.parse(verseNo);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: appColor.textColor),
        title: Text('Verse View', style: TextStyle(color: appColor.textColor)),
        backgroundColor: appColor.background,
        actions: [
          IconButton(
            onPressed: () {
              if (fontSize > 14) {
                ref.read(fontChanger.notifier).state--;
              }
            },
            icon: Icon(Icons.remove_circle, color: appColor.textColor),
          ),
          IconButton(
            onPressed: () {
              if (fontSize < 20) {
                ref.read(fontChanger.notifier).state++;
              }
            },
            icon: Icon(Icons.add, color: appColor.textColor),
          ),
        ],
      ),
      body: verses.when(
        data: (chapters) {
          final chapterIndex = int.parse(chapterNo) - 1;
          final verseIndex = int.parse(verseNo) - 1;
          final versesList = chapters[chapterIndex + 1]['data'];

          return ListView.builder(
            itemCount: versesList.length,
            itemBuilder: (context, index) {
              final verse = versesList[index];
              return Container(
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  gradient: appColor.gradienttap.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Verse ${verse['verse']}: ',
                      style: TextStyle(
                        color: appColor.textColor,
                        fontSize: fontSize.toDouble(),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        verse['text'],
                        style: TextStyle(
                          fontSize: fontSize.toDouble(),
                          color: appColor.textColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        error: (error, stack) => Center(child: Text('Error: $error')),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
