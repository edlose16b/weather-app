import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_app/app/ui/paddings.dart';

class HomeHeaderSkeleto extends StatelessWidget {
  const HomeHeaderSkeleto({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[200]!,
          child: Container(
            height: 200,
            width: 200,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: Paddings.medium),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[200]!,
          child: Text(
            'Loading...',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: Paddings.medium),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[200]!,
          child: Container(
            width: MediaQuery.of(context).size.width * .8,
            height: 20,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
