package com.ironfist.stickerz.sticker

import android.app.Activity
import android.content.ActivityNotFoundException
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.net.Uri
import android.os.Build
import com.ironfist.stickerz.BuildConfig
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream
import java.util.concurrent.Executors

class StickerBridge(
    private val activity: Activity,
    private val takeIncomingPack: () -> String?,
    private val copyImportUri: (String) -> String?,
) : MethodChannel.MethodCallHandler {
    private var channel: MethodChannel? = null
    private var pendingResult: MethodChannel.Result? = null
    private val worker = Executors.newSingleThreadExecutor()

    fun configure(binaryMessenger: BinaryMessenger) {
        channel = MethodChannel(binaryMessenger, StickerContract.channelName)
        channel?.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            StickerContract.methodEncodeWebp -> encodeWebp(call, result)
            StickerContract.methodGetPacksDirectory -> {
                result.success(StickerFiles.packsRoot(activity).absolutePath)
            }
            StickerContract.methodGetTargets -> result.success(mapOf("installed" to installedTargets().map { it.wire }))
            StickerContract.methodCanAddPack -> canAddPack(call, result)
            StickerContract.methodAddPack -> addPack(call, result)
            StickerContract.methodTakeIncomingPack -> result.success(takeIncomingPack())
            StickerContract.methodCopyImportUri -> {
                val uri = call.argument<String>("uri")
                if (uri.isNullOrBlank()) {
                    result.success(null)
                } else {
                    worker.execute {
                        val copied = copyImportUri(uri)
                        activity.runOnUiThread { result.success(copied) }
                    }
                }
            }
            else -> result.notImplemented()
        }
    }

    fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode != StickerContract.addPackRequestCode) {
            return false
        }
        val callback = pendingResult ?: return true
        pendingResult = null
        when (resultCode) {
            Activity.RESULT_OK -> callback.success(mapOf("status" to "completed"))
            Activity.RESULT_CANCELED -> {
                val validation = data?.getStringExtra(StickerContract.validationError)
                if (validation.isNullOrBlank()) {
                    callback.success(mapOf("status" to "cancelled"))
                } else {
                    callback.success(
                        mapOf(
                            "status" to "rejected",
                            "validationError" to validation,
                        ),
                    )
                }
            }
            else -> callback.success(mapOf("status" to "cancelled"))
        }
        return true
    }

    private fun encodeWebp(call: MethodCall, result: MethodChannel.Result) {
        val bytes = call.argument<ByteArray>("bytes")
        val quality = (call.argument<Int>("quality") ?: 100).coerceIn(0, 100)
        val lossless = call.argument<Boolean>("lossless") ?: false
        if (bytes == null || bytes.isEmpty()) {
            result.error("invalid_args", "Missing source image bytes.", null)
            return
        }

        worker.execute {
            encodeWebpBytes(bytes, quality, lossless, result)
        }
    }

    private fun encodeWebpBytes(
        bytes: ByteArray,
        quality: Int,
        lossless: Boolean,
        result: MethodChannel.Result,
    ) {
        val bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.size)
        if (bitmap == null) {
            activity.runOnUiThread {
                result.error("decode_failed", "Failed to decode the source image.", null)
            }
            return
        }

        val format = when {
            Build.VERSION.SDK_INT >= Build.VERSION_CODES.R && lossless -> Bitmap.CompressFormat.WEBP_LOSSLESS
            Build.VERSION.SDK_INT >= Build.VERSION_CODES.R -> Bitmap.CompressFormat.WEBP_LOSSY
            else -> Bitmap.CompressFormat.WEBP
        }

        val stream = ByteArrayOutputStream(bytes.size)
        try {
            if (!bitmap.compress(format, quality, stream)) {
                activity.runOnUiThread {
                    result.error("encode_failed", "Failed to encode the image as WebP.", null)
                }
                return
            }
            val encoded = stream.toByteArray()
            activity.runOnUiThread { result.success(encoded) }
        } finally {
            bitmap.recycle()
            stream.close()
        }
    }

    private fun canAddPack(call: MethodCall, result: MethodChannel.Result) {
        val packId = call.argument<String>("packId")?.trim()?.lowercase()
        if (packId.isNullOrEmpty()) {
            result.success(mapOf("installed" to emptyList<String>(), "whitelisted" to emptyList<String>()))
            return
        }
        val installed = installedTargets()
        val whitelisted = installed.filter { target -> isWhitelisted(packId, target) }
        result.success(
            mapOf(
                "installed" to installed.map { it.wire },
                "whitelisted" to whitelisted.map { it.wire },
            ),
        )
    }

    private fun addPack(call: MethodCall, result: MethodChannel.Result) {
        val packId = call.argument<String>("packId")?.trim()?.lowercase()
        val packName = call.argument<String>("packName")?.trim()
        if (packId.isNullOrEmpty() || packName.isNullOrEmpty() || pendingResult != null) {
            result.success(mapOf("status" to "providerUnavailable"))
            return
        }

        val installed = installedTargets()
        if (installed.isEmpty()) {
            result.success(mapOf("status" to "missing"))
            return
        }

        val available = installed.filterNot { isWhitelisted(packId, it) }
        if (available.isEmpty()) {
            result.success(mapOf("status" to "alreadyAdded"))
            return
        }

        val intent = Intent(StickerContract.actionEnableStickerPack).apply {
            putExtra(StickerContract.extraPackId, packId)
            putExtra(StickerContract.extraPackAuthority, BuildConfig.STICKER_PROVIDER_AUTHORITY)
            putExtra(StickerContract.extraPackName, packName)
        }
        val launchIntent = if (available.size == 1) {
            intent.apply { setPackage(available.first().packageName) }
        } else {
            Intent.createChooser(intent, packName)
        }

        pendingResult = result
        try {
            activity.startActivityForResult(launchIntent, StickerContract.addPackRequestCode)
        } catch (_: ActivityNotFoundException) {
            pendingResult = null
            result.success(mapOf("status" to "missing"))
        } catch (_: Exception) {
            pendingResult = null
            result.success(mapOf("status" to "providerUnavailable"))
        }
    }

    private fun installedTargets(): List<Target> {
        return Target.entries.filter { target -> isPackageInstalled(target.packageName) }
    }

    private fun isPackageInstalled(packageName: String): Boolean {
        return try {
            @Suppress("DEPRECATION")
            activity.packageManager.getPackageInfo(packageName, 0)
            true
        } catch (_: Exception) {
            false
        }
    }

    private fun isWhitelisted(packId: String, target: Target): Boolean {
        val uri = Uri.Builder()
            .scheme("content")
            .authority(target.whitelistAuthority)
            .appendPath(StickerContract.whitelistPath)
            .appendQueryParameter("authority", BuildConfig.STICKER_PROVIDER_AUTHORITY)
            .appendQueryParameter("identifier", packId)
            .build()

        return try {
            activity.contentResolver.query(uri, null, null, null, null)?.use { cursor ->
                val column = cursor.getColumnIndex(StickerContract.whitelistResultColumn)
                cursor.moveToFirst() && column >= 0 && cursor.getInt(column) == 1
            } ?: false
        } catch (_: Exception) {
            false
        }
    }

    private enum class Target(
        val wire: String,
        val packageName: String,
        val whitelistAuthority: String,
    ) {
        CONSUMER(
            wire = "consumer",
            packageName = StickerContract.consumerPackage,
            whitelistAuthority = StickerContract.consumerWhitelistAuthority,
        ),
        BUSINESS(
            wire = "business",
            packageName = StickerContract.businessPackage,
            whitelistAuthority = StickerContract.businessWhitelistAuthority,
        ),
    }
}
