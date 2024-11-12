/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// Directory path: assets/icons/social_medias
  $AssetsIconsSocialMediasGen get socialMedias =>
      const $AssetsIconsSocialMediasGen();
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/magic_password.png
  AssetGenImage get magicPassword =>
      const AssetGenImage('assets/images/magic_password.png');

  /// List of all assets
  List<AssetGenImage> get values => [magicPassword];
}

class $AssetsJsonsGen {
  const $AssetsJsonsGen();

  /// File path: assets/jsons/loading_lotie.json
  String get loadingLotie => 'assets/jsons/loading_lotie.json';

  /// Directory path: assets/jsons/themes
  $AssetsJsonsThemesGen get themes => const $AssetsJsonsThemesGen();

  /// List of all assets
  List<String> get values => [loadingLotie];
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/en-US.json
  String get enUS => 'assets/translations/en-US.json';

  /// File path: assets/translations/vi-VN.json
  String get viVN => 'assets/translations/vi-VN.json';

  /// List of all assets
  List<String> get values => [enUS, viVN];
}

class $AssetsIconsSocialMediasGen {
  const $AssetsIconsSocialMediasGen();

  /// File path: assets/icons/social_medias/icons8_facebook_500.svg
  String get icons8Facebook500 =>
      'assets/icons/social_medias/icons8_facebook_500.svg';

  /// File path: assets/icons/social_medias/icons8_facebook_messenger_500.svg
  String get icons8FacebookMessenger500 =>
      'assets/icons/social_medias/icons8_facebook_messenger_500.svg';

  /// File path: assets/icons/social_medias/icons8_instagram_500.svg
  String get icons8Instagram500 =>
      'assets/icons/social_medias/icons8_instagram_500.svg';

  /// File path: assets/icons/social_medias/icons8_linkedin_500.svg
  String get icons8Linkedin500 =>
      'assets/icons/social_medias/icons8_linkedin_500.svg';

  /// File path: assets/icons/social_medias/icons8_telegram_app_500.svg
  String get icons8TelegramApp500 =>
      'assets/icons/social_medias/icons8_telegram_app_500.svg';

  /// File path: assets/icons/social_medias/icons8_tiktok_500.svg
  String get icons8Tiktok500 =>
      'assets/icons/social_medias/icons8_tiktok_500.svg';

  /// List of all assets
  List<String> get values => [
        icons8Facebook500,
        icons8FacebookMessenger500,
        icons8Instagram500,
        icons8Linkedin500,
        icons8TelegramApp500,
        icons8Tiktok500
      ];
}

class $AssetsJsonsThemesGen {
  const $AssetsJsonsThemesGen();

  /// File path: assets/jsons/themes/app_theme_dark.json
  String get appThemeDark => 'assets/jsons/themes/app_theme_dark.json';

  /// File path: assets/jsons/themes/app_theme_light.json
  String get appThemeLight => 'assets/jsons/themes/app_theme_light.json';

  /// List of all assets
  List<String> get values => [appThemeDark, appThemeLight];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsJsonsGen jsons = $AssetsJsonsGen();
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
