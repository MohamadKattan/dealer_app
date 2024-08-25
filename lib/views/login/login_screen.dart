import 'package:auto_route/auto_route.dart';
import 'package:dealer/utilities/style_app/app_them/bloc/them_bloc.dart';
import 'package:dealer/utilities/ui_res_app/ui_responsev_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return UiResponsive.myUiBuilder(context, _body(context));
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeData>(builder: (context, state) {
      return SafeArea(
        child: Scaffold(
          body: TextButton(
              onPressed: () {
                context.read<ThemeBloc>().toggleTheme();
              },
              child: const Text('login')),
        ),
      );
    });
  }
}
