import 'package:cached_network_image_builder/cached_network_image_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memes/apis/get_meme.dart';
import 'package:memes/constants.dart';
import 'package:memes/screens/meme_details.dart';

class SubredditScreen extends StatefulWidget {
  final String? subreddit;
  const SubredditScreen({Key? key, required this.subreddit}) : super(key: key);

  @override
  _SubredditScreenState createState() => _SubredditScreenState();
}

class _SubredditScreenState extends State<SubredditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          widget.subreddit!,
          style: const TextStyle(color: appbarTextColor),
        ),
        iconTheme: const IconThemeData(
          color: appbarTextColor,
        ),
        backgroundColor: appbarColor,
      ),
      body: Center(
        child: FutureBuilder(
          future: getMemes(
            count: 10,
            subReddit: widget.subreddit != "random" ? widget.subreddit : null,
          ),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              MemeBig memeData = snapshot.data['data'];

              return Swiper(
                onIndexChanged: (index) {
                  if (index == 10) {
                    Get.off(
                      () => SubredditScreen(
                        subreddit: widget.subreddit,
                      ),
                      preventDuplicates: false,
                    );
                  }
                },
                autoplay: true,
                autoplayDelay: 10000,
                autoplayDisableOnInteraction: true,
                duration: 1000,
                control: SwiperControl(color: appbarTextColor),
                loop: false,
                itemCount: 11,
                itemBuilder: (BuildContext context, int index) {
                  return index != 10
                      ? Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                            right: 10,
                          ),
                          child: InkWell(
                            onTap: () {
                              Get.to(
                                () => MemeDetails(meme: memeData.memes![index]),
                                fullscreenDialog: true,
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImageBuilder(
                                url: memeData.memes![index].url!,
                                builder: (image) {
                                  return Center(
                                    child: Image.file(
                                      image,
                                      errorBuilder:
                                          (context, exception, index) {
                                        return SizedBox(
                                          height: 300,
                                          width: 300,
                                          child: Card(
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
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
                                  );
                                },

                                placeHolder: SizedBox(
                                  height: 300,
                                  width: 300,
                                  child: Card(
                                    elevation: 0,
                                    color: appbarColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: appbarTextColor,
                                      ),
                                    ),
                                  ),
                                ),
                                // Optional error widget
                                errorWidget: SizedBox(
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
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 300,
                          width: 300,
                          child: InkWell(
                            onLongPress: () {
                              Get.to(
                                  () => const SubredditScreen(
                                      subreddit: 'random'),
                                  fullscreenDialog: true);
                            },
                            child: Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              color: appbarColor,
                              child: const Center(
                                child: Text(
                                  'See more',
                                  style: TextStyle(color: appbarTextColor),
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
                    child: const Center(
                      child: Text(
                        'Unable to load memes',
                        style: TextStyle(color: appbarTextColor),
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
    );
  }
}
