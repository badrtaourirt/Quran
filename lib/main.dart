import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// ... (imports remain unchanged)

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: ListView.builder(
            itemCount: quran.getVerseCount(18),
            itemBuilder: (context, index) {
              return QuranVerseItem(verseIndex: index + 1, onTap: () {
                // Handle the tap event for the verse item
                // You can add your custom logic here
                print('Verse ${quran.getVerse(18, index + 1, verseEndSymbol: true)} tapped!');
              });
            },
          ),
        ),
      ),
    );
  }
}

class QuranVerseItem extends StatelessWidget {
  final int verseIndex;
  final VoidCallback onTap;

  const QuranVerseItem({Key? key, required this.verseIndex, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Container for verse index
            Container(
              height: 50,
              width: 50,
              color: Colors.black,
              margin: EdgeInsets.all(2),
              child: Center(
                child: Text(
                  verseIndex.toString(),
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            // Container for surah name
            Container(
              height: 50,
              width: 260,
              color: Colors.white,
              margin: EdgeInsets.all(2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    quran.getSurahNameEnglish(verseIndex),
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    quran.getSurahNameArabic(verseIndex),
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            ),
            // Container for verse index (again)
            Container(
              height: 50,
              width: 50,
              color: Colors.black,
              margin: EdgeInsets.all(2),
              child: Center(
                child: Text(
                  verseIndex.toString(),
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
