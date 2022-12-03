class Wind {
  Wind({
    required this.speed,
    required this.deg,
    this.gust,
  });

  final double speed;
  final int deg;
  final double? gust;
}
