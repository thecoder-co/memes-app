import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memes/components/meme_row.dart';
import 'package:memes/constants.dart';
import 'package:memes/screens/subreddit_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Memes',
          style: GoogleFonts.patrickHand(
            color: appbarTextColor,
            fontSize: 25,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              String? subreddit = '';
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: Text(
                      'Search',
                      style: GoogleFonts.patrickHand(
                        color: infoTextColor,
                      ),
                    ),
                    backgroundColor: backgroundColor,
                    content: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for custom subreddit',
                        hintStyle: TextStyle(
                          color: infoTextColor.withOpacity(0.5),
                        ),
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: appbarTextColor,
                          ),
                        ),
                      ),
                      cursorColor: appbarTextColor,
                      style: const TextStyle(
                        color: appbarTextColor,
                      ),
                      autocorrect: true,
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      onSubmitted: (word) {
                        subreddit = word;
                      },
                      onChanged: (word) {
                        subreddit = word;
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: appbarTextColor,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (subreddit!.isNotEmpty) {
                            Get.back();
                            Get.to(
                              () => SubredditScreen(subreddit: subreddit),
                            );
                          }
                        },
                        child: const Text(
                          'Search',
                          style: TextStyle(
                            color: appbarTextColor,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
        actionsIconTheme: const IconThemeData(color: appbarTextColor),
        backgroundColor: appbarColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            MemeRow(),
            MemeRow(
              subreddit: 'me_irl',
            ),
            MemeRow(
              subreddit: 'dankmemes',
            ),
            MemeRow(
              subreddit: 'wholesomememes',
            ),
            MemeRow(
              subreddit: 'surrealmemes',
            ),
            MemeRow(
              subreddit: 'MemeEconomy',
            ),
            MemeRow(
              subreddit: 'funny',
            ),
            MemeRow(
              subreddit: 'memes',
            ),
          ],
        ),
      ),
    );
  }
}
