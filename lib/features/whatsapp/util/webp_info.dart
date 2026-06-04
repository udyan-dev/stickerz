class WebpInfo {
  const WebpInfo({
    required this.width,
    required this.height,
    required this.animated,
    required this.totalDurationMs,
    required this.minFrameDurationMs,
  });

  final int width;
  final int height;
  final bool animated;
  final int totalDurationMs;
  final int minFrameDurationMs;
}
