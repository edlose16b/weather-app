import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ForecastSkeleto extends StatelessWidget {
  const ForecastSkeleto({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[200]!,
      child: SizedBox(
        height: 190,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              width: 120,
              height: 190,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            );
          },
          shrinkWrap: true,
          itemCount: 3,
        ),
      ),
    );
  }
}
