import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;

class SecondPage extends StatefulWidget {
  final int message;

  SecondPage({required this.message});

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int pageIndex = 0;
  int itemsPerPage = 6; // Adjust this based on your preference

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(quran.getSurahName(widget.message)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: PageView.builder(
            itemCount: (quran.getVerseCount(widget.message) / itemsPerPage).ceil(),
            itemBuilder: (context, index) {
              final startVerseIndex = index * itemsPerPage + 1;
              final endVerseIndex = (index + 1) * itemsPerPage;

              return VerseList(
                startVerseIndex: startVerseIndex,
                endVerseIndex: endVerseIndex,
                message: widget.message,
              );
            },
            onPageChanged: (index) {
              setState(() {
                pageIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}

class VerseList extends StatelessWidget {
  final int startVerseIndex;
  final int endVerseIndex;
  final int message;

  VerseList({
    required this.startVerseIndex,
    required this.endVerseIndex,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: endVerseIndex - startVerseIndex + 1,
      itemBuilder: (context, index) {
        final verseIndex = startVerseIndex + index;

        return ListTile(
          title: Text(
            quran.getVerse(message, verseIndex, verseEndSymbol: true),
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        );
      },
    );
  }
}
