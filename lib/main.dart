import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DemoApp(),
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
    );
  }
}

class DemoApp extends StatefulWidget {
  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  List<int> data = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1];
  List<Color> colors = [
    Colors.black,
    Colors.purple,
    Colors.red,
    Colors.blue,
    Colors.pink,
    Colors.deepPurpleAccent,
    Colors.teal,
    Colors.orangeAccent,
    Colors.green,
    Colors.lightGreen
  ];

  int selectedIndex = 5;

  Color bgColor = Colors.purple;

  ValueNotifier<Color> colorNotifier = ValueNotifier(Colors.purple);

  changeColor(int index) {
    colorNotifier.value = colors[index];
  }

  Widget _buildItemList(BuildContext context, int index) {
    if (index == data.length) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      width: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 100,
            decoration: BoxDecoration(
              color: colors[index],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '${data[index]}',
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Horizontal list',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: 120,
            child: ScrollSnapList(
              itemBuilder: _buildItemList,
              itemSize: 80,
              initialIndex: 2,
              dynamicItemSize: true,
              // dynamicItemSize: false,
              dynamicItemOpacity: 0.8,
              duration: 100,
              onReachEnd: () {
                print('Done!');
              },
              itemCount: data.length,
              onItemFocus: (int) {
                print(int);
                changeColor(int);
              },
            ),
          ),
          Expanded(
              child: ValueListenableBuilder(
            valueListenable: colorNotifier,
            builder: (context, value, child) {
              return Container(
                width: double.maxFinite,
                alignment: Alignment.center,
                color: colorNotifier.value,
                child: GestureDetector(
                  onDoubleTap: (){
                    colorNotifier.value = colors[2];
                  },
                    child: const Text('Calendar List')),
              );
            },
          ))
        ],
      ),
    );
  }
}
