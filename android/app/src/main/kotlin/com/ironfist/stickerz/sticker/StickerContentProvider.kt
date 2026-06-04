package com.ironfist.stickerz.sticker

import android.content.ContentProvider
import android.content.ContentValues
import android.content.UriMatcher
import android.content.res.AssetFileDescriptor
import android.database.Cursor
import android.net.Uri
import android.os.ParcelFileDescriptor
import com.ironfist.stickerz.BuildConfig

class StickerContentProvider : ContentProvider() {
    private val matcher = UriMatcher(UriMatcher.NO_MATCH).apply {
        addURI(BuildConfig.STICKER_PROVIDER_AUTHORITY, StickerContract.metadata, StickerContract.metadataCode)
        addURI(BuildConfig.STICKER_PROVIDER_AUTHORITY, "${StickerContract.metadata}/*", StickerContract.metadataPackCode)
        addURI(BuildConfig.STICKER_PROVIDER_AUTHORITY, "${StickerContract.stickers}/*", StickerContract.stickersCode)
        addURI(BuildConfig.STICKER_PROVIDER_AUTHORITY, "${StickerContract.stickersAsset}/*/*", StickerContract.stickersAssetCode)
    }

    override fun onCreate(): Boolean {
        val context = context ?: return false
        return BuildConfig.STICKER_PROVIDER_AUTHORITY == "${context.packageName}.stickercontentprovider"
    }

    override fun query(
        uri: Uri,
        projection: Array<out String>?,
        selection: String?,
        selectionArgs: Array<out String>?,
        sortOrder: String?,
    ): Cursor? {
        val context = context ?: return null
        val cursor = when (matcher.match(uri)) {
            StickerContract.metadataCode -> StickerCursor.metadata(StickerFiles.listPacks(context))
            StickerContract.metadataPackCode -> {
                val packId = uri.lastPathSegment ?: return null
                StickerCursor.metadata(listOfNotNull(StickerFiles.readPack(context, packId)))
            }
            StickerContract.stickersCode -> {
                val packId = uri.lastPathSegment ?: return null
                StickerCursor.stickers(StickerFiles.readPack(context, packId))
            }
            else -> throw IllegalArgumentException("Unknown URI: $uri")
        }
        cursor.setNotificationUri(context.contentResolver, uri)
        return cursor
    }

    override fun openAssetFile(uri: Uri, mode: String): AssetFileDescriptor? {
        if (mode != "r" || matcher.match(uri) != StickerContract.stickersAssetCode) {
            return null
        }
        val context = context ?: return null
        val segments = uri.pathSegments
        if (segments.size != 3) {
            return null
        }
        val file = StickerFiles.resolveAsset(context, segments[1], segments[2]) ?: return null
        val descriptor = ParcelFileDescriptor.open(file, ParcelFileDescriptor.MODE_READ_ONLY)
        return AssetFileDescriptor(descriptor, 0, AssetFileDescriptor.UNKNOWN_LENGTH)
    }

    override fun getType(uri: Uri): String {
        return when (matcher.match(uri)) {
            StickerContract.metadataCode -> "vnd.android.cursor.dir/vnd.${BuildConfig.STICKER_PROVIDER_AUTHORITY}.${StickerContract.metadata}"
            StickerContract.metadataPackCode -> "vnd.android.cursor.item/vnd.${BuildConfig.STICKER_PROVIDER_AUTHORITY}.${StickerContract.metadata}"
            StickerContract.stickersCode -> "vnd.android.cursor.dir/vnd.${BuildConfig.STICKER_PROVIDER_AUTHORITY}.${StickerContract.stickers}"
            StickerContract.stickersAssetCode -> "image/webp"
            else -> throw IllegalArgumentException("Unknown URI: $uri")
        }
    }

    override fun insert(uri: Uri, values: ContentValues?): Uri {
        throw UnsupportedOperationException("Not supported")
    }

    override fun delete(uri: Uri, selection: String?, selectionArgs: Array<out String>?): Int {
        throw UnsupportedOperationException("Not supported")
    }

    override fun update(
        uri: Uri,
        values: ContentValues?,
        selection: String?,
        selectionArgs: Array<out String>?,
    ): Int {
        throw UnsupportedOperationException("Not supported")
    }
}
