import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/env/env.dart';

class DependejencyInjections extends StatelessWidget {
  const DependejencyInjections({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider<Env>(create: (_) => DevEnv())],
      child: child,
    );
  }
}
