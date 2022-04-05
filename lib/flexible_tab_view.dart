import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class FlexibleTabView extends StatefulWidget {
  final List<Widget> pages;
  final TabController tabController;
  const FlexibleTabView(
      {Key? key, required this.pages, required this.tabController})
      : super(key: key);

  @override
  State<FlexibleTabView> createState() => FlexibleTabViewState();
}

class FlexibleTabViewState extends State<FlexibleTabView> {
  List<double>? pageHeights;
  late List<GlobalKey> pageKeys;

  @override
  initState() {
    super.initState();
    pageKeys = List.generate(widget.pages.length, (i) => GlobalKey());
  }

  @override
  Widget build(BuildContext context) {
    if (pageHeights == null) {
      SchedulerBinding.instance?.endOfFrame.then((value) {
        pageHeights = [];
        pageKeys.forEach((key) {
          pageHeights?.add(key.currentContext?.size?.height ?? 0);
        });
        setState(() {});
      });
      return Column(
        children: [
          ...List.generate(
            widget.pages.length,
            (i) => Container(
              key: pageKeys[i],
              child: widget.pages[i],
            ),
          )
        ],
      );
    } else {
      return AnimatedBuilder(
        animation: widget.tabController.animation!,
        builder: (context, _) {
          return SizedBox(
            height: lerpDouble(
                pageHeights![widget.tabController.animation!.value.floor()],
                pageHeights![widget.tabController.animation!.value.ceil()],
                widget.tabController.animation!.value),
            child: TabBarView(
              controller: widget.tabController,
              children: widget.pages,
            ),
          );
        },
      );
    }
  }
}
