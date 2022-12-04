import 'package:flutter/material.dart';

class MinMaxTemperatureWidget extends StatelessWidget {
  const MinMaxTemperatureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildMin(),
        _buildMax(),
      ],
    );
  }

  Widget _buildMin() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(
          Icons.air,
          color: Color(0xff232436),
        ),
        Text(
          '22°',
        ),
      ],
    );
  }

  Widget _buildMax() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(
          Icons.air,
          color: Color(0xff232436),
        ),
        Text(
          '22°',
        ),
      ],
    );
  }
}
