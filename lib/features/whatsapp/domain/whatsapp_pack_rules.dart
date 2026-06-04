class WhatsAppPackRules {
  const WhatsAppPackRules._();

  static const int minStickers = 3;
  static const int maxStickers = 30;
  static const int stickerSize = 512;
  static const int traySize = 96;
  static const int staticStickerMaxBytes = 100 * 1024;
  static const int animatedStickerMaxBytes = 500 * 1024;
  static const int trayMaxBytes = 50 * 1024;
  static const int packNameMaxLength = 128;
  static const int publisherMaxLength = 128;
  static const int staticAccessibilityMaxLength = 125;
  static const int animatedAccessibilityMaxLength = 255;
  static const int maxAnimatedDurationMs = 10000;
  static const int minAnimatedFrameDurationMs = 8;
}
