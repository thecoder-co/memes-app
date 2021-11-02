import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memes/apis/get_meme.dart';
import 'package:memes/constants.dart';
import 'package:memes/screens/meme_details.dart';
import 'package:memes/screens/subreddit_screen.dart';

class MemeRow extends StatelessWidget {
  final String? subreddit;
  const MemeRow({
    Key? key,
    this.subreddit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
          child: Text(
            subreddit == null ? 'Random memes:' : subreddit! + ':',
            style: GoogleFonts.patrickHand(
              color: infoTextColor,
              fontSize: 20,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16),
          child: Divider(
            color: appbarTextColor,
          ),
        ),
        SizedBox(
          height: 300,
          child: FutureBuilder(
            future: getMemes(count: 50, subReddit: subreddit),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                MemeBig memeData = snapshot.data['data'];

                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 51,
                  shrinkWrap: true,
                  separatorBuilder: (context, int index) {
                    return const SizedBox(width: 0, height: 20);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return index != 50
                        ? Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10,
                            ),
                            child: InkWell(
                              onTap: () {
                                Get.to(
                                  () =>
                                      MemeDetails(meme: memeData.memes![index]),
                                  fullscreenDialog: true,
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  memeData.memes![index].url!,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return SizedBox(
                                      height: 300,
                                      width: 300,
                                      child: Card(
                                        elevation: 0,
                                        color: appbarColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: appbarTextColor,
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, exception, index) {
                                    return SizedBox(
                                      height: 300,
                                      width: 300,
                                      child: Card(
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        color: appbarColor,
                                        child: Center(
                                          child: Text(
                                            'Unable to load meme',
                                            style: GoogleFonts.patrickHand(
                                              color: appbarTextColor,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 300,
                            width: 300,
                            child: InkWell(
                              onTap: () {
                                Get.to(
                                  () => SubredditScreen(
                                      subreddit: subreddit == null
                                          ? 'random'
                                          : subreddit!),
                                );
                              },
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                color: appbarColor,
                                child: Center(
                                  child: Text(
                                    'See more',
                                    style: GoogleFonts.patrickHand(
                                      color: appbarTextColor,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                  },
                );
              } else if (snapshot.hasError) {
                //print(snapshot.data);
                return Center(
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      color: appbarColor,
                      child: Center(
                        child: Text(
                          'Unable to load memes',
                          style: GoogleFonts.patrickHand(
                            color: appbarTextColor,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: appbarTextColor,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
