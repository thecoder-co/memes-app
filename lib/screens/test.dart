import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memes/apis/get_meme.dart';
import 'package:memes/components/meme_card.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  late Future data;
  @override
  void initState() {
    super.initState();
    data = getMemes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: FutureBuilder(
              future: data,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  Map returnedData = snapshot.data;
                  if (returnedData['isLarge']) {
                    MemeBig memeData = returnedData['data'];
                    return Center(
                      child: MemeCard(
                        meme: memeData.memes![0],
                      ),
                    );
                  } else {
                    MemeSmall memeData = returnedData['data'];
                    return Center(
                      child: MemeCard(meme: memeData.toMeme()),
                    );
                  }
                } else if (snapshot.hasError) {
                  Get.snackbar('Error', 'Unable to load data');
                  return const Center(
                    child: Text('Unable to load meme'),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
