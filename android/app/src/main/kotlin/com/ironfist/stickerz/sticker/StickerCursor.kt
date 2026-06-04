package com.ironfist.stickerz.sticker

import android.database.MatrixCursor

object StickerCursor {
    fun metadata(packs: List<StickerPackRecord>): MatrixCursor {
        val cursor = MatrixCursor(
            arrayOf(
                StickerContract.metadataIdentifier,
                StickerContract.metadataName,
                StickerContract.metadataPublisher,
                StickerContract.metadataIcon,
                StickerContract.metadataAndroidLink,
                StickerContract.metadataIosLink,
                StickerContract.metadataPublisherEmail,
                StickerContract.metadataPublisherWebsite,
                StickerContract.metadataPrivacyPolicy,
                StickerContract.metadataLicense,
                StickerContract.metadataVersion,
                StickerContract.metadataAvoidCache,
                StickerContract.metadataAnimated,
            ),
            packs.size,
        )
        packs.forEach { pack ->
            cursor.addRow(
                arrayOf<Any?>(
                    pack.id,
                    pack.name,
                    pack.publisher,
                    pack.trayFile,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    pack.version.toString(),
                    false,
                    pack.animated,
                ),
            )
        }
        return cursor
    }

    fun stickers(pack: StickerPackRecord?): MatrixCursor {
        val stickers = pack?.stickers.orEmpty()
        val cursor = MatrixCursor(
            arrayOf(
                StickerContract.stickerFileName,
                StickerContract.stickerEmoji,
                StickerContract.stickerAccessibilityText,
            ),
            stickers.size,
        )
        stickers.forEach { sticker ->
            cursor.addRow(
                arrayOf<Any?>(
                    sticker.fileName,
                    sticker.emojis.joinToString(","),
                    sticker.accessibilityText,
                ),
            )
        }
        return cursor
    }
}
