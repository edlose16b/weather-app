import 'package:flutter/material.dart';

class MinMaxTemperatureWidget extends StatelessWidget {
  const MinMaxTemperatureWidget({
    super.key,
    required this.min,
    required this.max,
  });

  final double min;
  final double max;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildMin(context),
        _buildMax(context),
      ],
    );
  }

  Widget _buildMin(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.air,
          color: Color(0xff232436),
          size: 23,
        ),
        Text(
          '$min°',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: Theme.of(context).textTheme.bodyText1!.fontSize! - 1,
              ),
        ),
      ],
    );
  }

  Widget _buildMax(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.air,
          color: Color(0xff232436),
        ),
        Text(
          '$max°',
          style: Theme.of(context).textTheme.bodyText1!,
        ),
      ],
    );
  }
}
