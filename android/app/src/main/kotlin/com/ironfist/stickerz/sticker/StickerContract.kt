package com.ironfist.stickerz.sticker

object StickerContract {
    const val channelName = "stickerz/core"
    const val methodEncodeWebp = "encodeWebp"
    const val methodGetPacksDirectory = "getPacksDirectory"
    const val methodGetTargets = "getTargets"
    const val methodCanAddPack = "canAddPack"
    const val methodAddPack = "addPack"
    const val methodTakeIncomingPack = "takeIncomingPack"
    const val methodCopyImportUri = "copyImportUri"

    const val metadata = "metadata"
    const val stickers = "stickers"
    const val stickersAsset = "stickers_asset"

    const val metadataCode = 1
    const val metadataPackCode = 2
    const val stickersCode = 3
    const val stickersAssetCode = 4

    const val metadataIdentifier = "sticker_pack_identifier"
    const val metadataName = "sticker_pack_name"
    const val metadataPublisher = "sticker_pack_publisher"
    const val metadataIcon = "sticker_pack_icon"
    const val metadataAndroidLink = "android_play_store_link"
    const val metadataIosLink = "ios_app_download_link"
    const val metadataPublisherEmail = "sticker_pack_publisher_email"
    const val metadataPublisherWebsite = "sticker_pack_publisher_website"
    const val metadataPrivacyPolicy = "sticker_pack_privacy_policy_website"
    const val metadataLicense = "sticker_pack_license_agreement_website"
    const val metadataVersion = "image_data_version"
    const val metadataAvoidCache = "whatsapp_will_not_cache_stickers"
    const val metadataAnimated = "animated_sticker_pack"

    const val stickerFileName = "sticker_file_name"
    const val stickerEmoji = "sticker_emoji"
    const val stickerAccessibilityText = "sticker_accessibility_text"

    const val actionEnableStickerPack = "com.whatsapp.intent.action.ENABLE_STICKER_PACK"
    const val extraPackId = "sticker_pack_id"
    const val extraPackAuthority = "sticker_pack_authority"
    const val extraPackName = "sticker_pack_name"
    const val validationError = "validation_error"

    const val addPackRequestCode = 4201

    const val consumerPackage = "com.whatsapp"
    const val businessPackage = "com.whatsapp.w4b"
    const val consumerWhitelistAuthority = "com.whatsapp.provider.sticker_whitelist_check"
    const val businessWhitelistAuthority = "com.whatsapp.w4b.provider.sticker_whitelist_check"
    const val whitelistPath = "is_whitelisted"
    const val whitelistResultColumn = "result"
}
