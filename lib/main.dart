import 'package:flexible_tab_view_flutter/flexible_tab_view.dart';
import 'package:flutter/material.dart';

//
const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late TabController tabs;

  @override
  initState() {
    super.initState();
    tabs = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Container(
                height: 100,
                color: Colors.green,
                child: const Center(
                  child: Text("Above flexible tab"),
                ),
              ),
              TabBar(
                tabs: const [
                  Tab(child: Text('Page 1')),
                  Tab(child: Text('Page 2')),
                ],
                controller: tabs,
              ),
              FlexibleTabView(tabController: tabs, pages: [
                Container(
                  height: 100,
                  color: Colors.red,
                  child: const Center(
                    child: Text("Page 1"),
                  ),
                ),
                Container(
                  height: 300,
                  color: Colors.blue,
                  child: const Center(
                    child: Text("Page 2"),
                  ),
                ),
              ]),
              Container(
                height: 100,
                color: Colors.green,
                child: const Center(
                  child: Text("After flexible tab"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
