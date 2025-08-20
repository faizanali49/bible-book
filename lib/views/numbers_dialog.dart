import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showNumbersDialog(
  BuildContext context,
  isDark,
  appColor,
  totalVerses,
  // List verseText,
  chapterNo,
) {
  showDialog(
    context: context,
    builder: (context) {
      int verse = totalVerses;
      int chapterNum = chapterNo;
      // print(verse);
      // debugPrint(verseText.toString());
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: AlertDialog(
          backgroundColor: appColor.textColor.withValues(alpha: 0.2),
          title: Center(
            child: Text(
              "Select a Verse",
              style: TextStyle(color: appColor.textColor),
            ),
          ),
          content: SizedBox(
            height: 400,
            width: double.maxFinite,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(8.0),
              ),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5, // number of columns
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 4,
                  childAspectRatio: 1,
                ),
                itemCount: verse, // Adjust the number of items as needed
                itemBuilder: (context, index) {
                  return Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: appColor.btn2,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: appColor.textColor),
                    ),
                    child: TextButton(
                      onPressed: () {
                        final verseNo = index;
                        GoRouter.of(context).push('/verse/$chapterNo/$verseNo');
                      },
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: appColor.textColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    },
  ).then((selectedNumber) {
    if (selectedNumber != null) {
      print("You selected: $selectedNumber");
    }
  });
}
