import 'package:auto_route/auto_route.dart';
import 'package:dealer/components/app_btn.dart';
import 'package:dealer/components/app_drawer.dart';
import 'package:dealer/controller/helper_methods_controller.dart';
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
    final isArabic = HelperMethods.isArabic(context);
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
            key: AppGetter.scaffoldKey,
            drawer: AppDrawer.drawer(context, isArabic),
            floatingActionButton: AppBtn.floatingBtn(
                onPressed: () => HelperMethods.toggelOpenCloseDrawer(),
                icon:
                    isArabic ? Icons.arrow_back_ios : Icons.arrow_forward_ios),
            floatingActionButtonLocation: isArabic
                ? FloatingActionButtonLocation.endFloat
                : FloatingActionButtonLocation.startFloat,
            body: const Text('HomePage')),
      ),
    );
  }
}
