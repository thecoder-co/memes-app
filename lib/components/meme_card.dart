import 'package:cached_network_image_builder/cached_network_image_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:memes/apis/get_meme.dart';
import 'package:memes/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MemeCard extends StatelessWidget {
  final Meme? meme;
  const MemeCard({
    Key? key,
    required this.meme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: appbarColor,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImageBuilder(
                url: meme!.url!,
                builder: (image) {
                  return Center(
                    child: Image.file(
                      image,
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Title: ${meme!.title!}",
                  style: GoogleFonts.patrickHand(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: infoTextColor,
                    ),
                  ),
                ),
                Text(
                  "Subreddit: ${meme!.subreddit!}",
                  style: GoogleFonts.patrickHand(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: infoTextColor,
                    ),
                  ),
                ),
                Text(
                  "Author: ${meme!.author!}",
                  style: GoogleFonts.patrickHand(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: infoTextColor,
                    ),
                  ),
                ),
                Text(
                  "Upvotes: ${meme!.ups!}",
                  style: GoogleFonts.josefinSans(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: infoTextColor,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.public),
                  onPressed: () async {
                    String url = Uri.encodeFull(meme!.postLink!);
                    //
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      Get.snackbar('error', 'could not launch url');
                    }
                  },
                  label: const Text('Go to post'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPrimary: appbarColor,
                    primary: appbarTextColor,
                    textStyle: GoogleFonts.patrickHand(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                ElevatedButton.icon(
                  icon: const Icon(Icons.download),
                  onPressed: () async {
                    try {
                      var imageId =
                          await ImageDownloader.downloadImage("${meme!.url}");
                      if (imageId == null) {
                        return;
                      }

                      Get.snackbar('Successful', 'Meme downloaded');
                    } catch (error) {
                      Get.snackbar('Failed', 'Unable to download meme');
                    }
                  },
                  label: const Text('Download Image'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPrimary: appbarColor,
                    primary: appbarTextColor,
                    textStyle: GoogleFonts.patrickHand(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                ElevatedButton.icon(
                  icon: const Icon(Icons.share),
                  onPressed: () async {
                    try {
                      var imageId =
                          await ImageDownloader.downloadImage("${meme!.url}");
                      if (imageId == null) {
                        return;
                      }

                      var path = await ImageDownloader.findPath(imageId);
                      Share.shareFiles(['$path'], text: '${meme!.title}');
                    } catch (error) {
                      Get.snackbar('Failed', 'Unable to share meme');
                    }
                  },
                  label: const Text('Share meme'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPrimary: appbarColor,
                    primary: appbarTextColor,
                    textStyle: GoogleFonts.patrickHand(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
