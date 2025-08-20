import 'dart:ui';

import 'package:bible/providers/api_future.dart';
import 'package:bible/providers/theme.dart';
import 'package:bible/styles/theme.dart';
import 'package:bible/views/numbers_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChapterView extends ConsumerWidget {
  const ChapterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeIsDark);
    final appColor = AppColor(isDarkMode: isDark);
    final verseExpand = ref.watch(isVerseExpanded);
    final chaptersAsync = ref.watch(bibleVersesProvider);

    // final expand = ref.watch(isExpanded);
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: appColor.background.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: chaptersAsync.when(
        data: (chapters) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Chapter View'),
              SizedBox(height: 12.0),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7, // number of columns
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  itemCount: chapters.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: appColor.background.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            // debugPrint('s');
                            // print('Chapter ${index + 1} pressed');
                            // print('${chapters[index]['data'][index]['text']}');
                            final totalVerses = int.parse(
                              chapters[index]['data'].last['verse'],
                            );
                            // final versesList = chapters[index]['data'];
                            final chapterNo = index + 1;

                            // print(lastVerse['text']); // gives the verse text
                            showNumbersDialog(
                              context,
                              isDark,
                              appColor,
                              totalVerses,
                              // versesList,
                              chapterNo,
                            );
                          },
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: appColor.textColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
        error: (error, stack) {
          // Handle the error
          return Center(child: Text('Error: $error'));
        },
        loading: () {
          // Show a loading indicator
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
