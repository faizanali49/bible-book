import 'package:bible/providers/api_future.dart';
import 'package:bible/providers/theme.dart';
import 'package:bible/styles/theme.dart';
import 'package:bible/views/chapter_view.dart';
import 'package:bible/views/verse_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<int> items = List.generate(14, (index) => index);
    final scaffoldKey = ref.watch(menukey);
    List<String> fruits = [
      'Genesis',
      'Exodus',
      'Leviticus',
      'Numbers',
      'Deuteronomy',
      'Joshua',
      'Judges',
      'Ruth',
      '1 Samuel',
      '2 Samuel',
      '1 Kings',
      '2 Kings',
      '1 Chronicles',
      '2 Chronicles',
      'Ezra',
      'Nehemiah',
      'Esther',
    ];

    final isDark = ref.watch(themeIsDark);
    final appColor = AppColor(isDarkMode: isDark);
    return Scaffold(
      backgroundColor: appColor.background,
      key: scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: appColor.background),
              child: Column(
                children: [
                  Text(
                    'Bible App Theme',
                    style: TextStyle(
                      color: appColor.textColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Switch(
                    value: isDark,
                    onChanged: (value) {
                      ref.read(themeIsDark.notifier).state = value;
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: appColor.textColor),
              title: Text('Home', style: TextStyle(color: appColor.textColor)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: appColor.textColor),
              title: Text(
                'Settings',
                style: TextStyle(color: appColor.textColor),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.menu, color: appColor.textColor),
                    onPressed: () {
                      scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Hi Jhon!',
                        style: TextStyle(
                          color: appColor.textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_active_outlined,
                      color: appColor.textColor,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: appColor.searchBarBackground.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 12.0,
                ),
                child: TextField(
                  style: TextStyle(color: appColor.textColor),
                  decoration: InputDecoration(
                    hint: Text(
                      'Search',
                      style: TextStyle(
                        color: appColor.textColor.withAlpha(140),
                      ),
                    ),
                    prefixIcon: Icon(Icons.search, color: appColor.textColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: appColor.textColor,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(color: appColor.textColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 140,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - 170,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: appColor.textColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: fruits.length,
                    itemBuilder: (context, index) {
                      final expand = ref.watch(isExpanded);
                      final verseExpand = ref.watch(isVerseExpanded);
                      final book = ref.watch(bookWhich);
                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                            ),
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: appColor.background2.withValues(
                                alpha: 0.6,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5.0,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.book_rounded,
                                  color: appColor.textColor,
                                ),
                                Text(
                                  fruits[index],
                                  style: TextStyle(
                                    color: appColor.textColor,
                                    fontSize: 16,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (expand != null && expand == index) {
                                      ref.read(isExpanded.notifier).state =
                                          null;
                                    } else {
                                      // Only update bookWhich if the book is different
                                      if (ref.read(bookWhich) !=
                                          fruits[index]) {
                                        ref.read(bookWhich.notifier).state =
                                            fruits[index].toLowerCase();
                                      }
                                      ref.read(isExpanded.notifier).state =
                                          index;
                                    }
                                  },
                                  icon: expand == index || verseExpand == index
                                      ? Icon(Icons.arrow_upward)
                                      : Icon(
                                          Icons.arrow_downward,
                                          color: appColor.textColor,
                                        ),
                                ),
                              ],
                            ),
                          ),
                          AnimatedContainer(
                            margin: EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                            duration: Duration(milliseconds: 800),
                            curve: Curves.easeInOut,
                            height: expand == index
                                ? 200
                                : verseExpand == index
                                ? 300
                                : 0,
                            child: expand == index ? ChapterView() : null,
                          ),
                        ],
                      );
                    },
                    physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
