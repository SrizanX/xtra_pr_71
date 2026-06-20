enum NetworkMode {
  secondGeneration(value: 0, label: "2G only", shortLabel: "2G"),
  thirdGeneration(value: 1, label: "3G/2G", shortLabel: "3G"),
  forthGeneration(value: 2, label: "4G/3G/2G", shortLabel: "4G");

  final int value;
  final String label;
  final String shortLabel;

  const NetworkMode({
    required this.value,
    required this.label,
    required this.shortLabel,
  });
}
