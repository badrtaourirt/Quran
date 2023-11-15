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
        title: Text(quran.getSurahNameArabic(widget.message)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: double.infinity,
          height: 100.0,
          color: Colors.blue,
          child: Center(
            child: Text(
              quran.getSurahNameArabic(message),
              style: TextStyle(color: Colors.white, fontSize: 40.0),
            ),
          ),  
        ), 
        Container(
          height: MediaQuery.of(context).size.height - 180, // Adjust height as needed
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://clipart-library.com/images/ki8ok46AT.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ListView.builder(
                padding: EdgeInsets.only(top: 50.0, bottom: 50.0), // Adjust padding as needed
                itemCount: endVerseIndex - startVerseIndex + 1,
                itemBuilder: (context, index) {
                  final verseIndex = startVerseIndex + index;

                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                      child: Text(
                        quran.getVerse(message, verseIndex, verseEndSymbol: true),
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
