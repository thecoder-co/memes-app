import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memes/apis/get_meme.dart';

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
      body: Container(
        child: FutureBuilder(
          future: data,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              Map returnedData = snapshot.data;
              if (returnedData['isLarge']) {
                MemeBig memeData = returnedData['data'];
                return Image.network(memeData.memes![0].url!);
              } else {
                MemeSmall memeData = returnedData['data'];
                return Image.network(memeData.url!);
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
    );
  }
}
