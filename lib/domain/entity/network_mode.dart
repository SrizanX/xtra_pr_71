enum NetworkMode {
  secondGeneration(value: 0, label: "2G only"),
  thirdGeneration(value: 1, label: "3G/2G"),
  forthGeneration(value: 2, label: "4G/3G/2G");

  final int value;
  final String label;

  const NetworkMode({required this.value, required this.label});
}
