import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingUpViews extends StatefulWidget {
  const SlidingUpViews({Key? key}) : super(key: key);

  @override
  _SlidingUpViewsState createState() => _SlidingUpViewsState();
}

class _SlidingUpViewsState extends State<SlidingUpViews> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: const Center(
          child: Text("This is the sliding Widget"),
        ),
      );
    }
}
