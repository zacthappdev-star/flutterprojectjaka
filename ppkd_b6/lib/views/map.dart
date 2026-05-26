import 'package:flutter/material.dart';
import 'package:ppkd_b6/data/hiragana_list.dart';

class ListWithMap extends StatefulWidget {
  const ListWithMap({super.key});
  @override
  State<ListWithMap> createState() => _ListWithMap();
}

class _ListWithMap extends State<ListWithMap> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(8),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: hiraganaList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: index % 2 == 0 ? Colors.blue : Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      hiraganaList[index]["character"],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      hiraganaList[index]["romaji"],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      hiraganaList[index]["description"],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
