import 'package:auto_route/auto_route.dart';
import 'package:dealer/utilities/dev_helper/app_getter.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Text('HomeScreen ${AppGetter.per}'),
      ),
    );
  }
}
