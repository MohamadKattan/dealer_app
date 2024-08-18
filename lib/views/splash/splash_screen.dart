
import 'package:dealer/views/splash/bloc/splash_bloc.dart';
import 'package:dealer/views/splash/bloc/splash_event.dart';
import 'package:dealer/views/splash/bloc/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Splash')),
      body: BlocBuilder<SplashBloc, SplashState>(
        builder: (context, state) {
          return Center(
              child: GestureDetector(
                  onTap: () {
                    context.read<SplashBloc>().add(ChangeVal());
                  },
                  child: Text(state.name ?? 'null')));
        },
      ),
    );
  }
}
