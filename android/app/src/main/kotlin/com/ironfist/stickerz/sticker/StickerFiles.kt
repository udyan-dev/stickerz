package com.ironfist.stickerz.sticker

import android.content.Context
import org.json.JSONArray
import org.json.JSONObject
import java.io.File

data class StickerAsset(
    val fileName: String,
    val emojis: List<String>,
    val accessibilityText: String,
)

data class StickerPackRecord(
    val id: String,
    val name: String,
    val publisher: String,
    val animated: Boolean,
    val trayFile: String,
    val version: Int,
    val stickers: List<StickerAsset>,
)

object StickerFiles {
    private const val packsDirectoryName = "packs"
    private const val manifestFileName = "manifest.json"
    private val safeIdPattern = Regex("^[a-z0-9][a-z0-9._-]{0,127}$")
    private val safeFilePattern = Regex("^[A-Za-z0-9][A-Za-z0-9._-]{0,127}$")

    fun listPacks(context: Context): List<StickerPackRecord> {
        val root = packsRoot(context)
        if (!root.isDirectory) {
            return emptyList()
        }
        return root.listFiles()
            ?.asSequence()
            ?.filter { it.isDirectory }
            ?.mapNotNull { directory -> readPack(directory, directory.name) }
            ?.sortedBy { pack -> pack.name.lowercase() }
            ?.toList()
            .orEmpty()
    }

    fun readPack(context: Context, packId: String): StickerPackRecord? {
        return readPack(File(packsRoot(context), packId), packId.trim().lowercase())
    }

    fun resolveAsset(context: Context, packId: String, fileName: String): File? {
        val pack = readPack(context, packId) ?: return null
        val knownFile = fileName == pack.trayFile || pack.stickers.any { sticker -> sticker.fileName == fileName }
        if (!knownFile) {
            return null
        }
        return resolveFile(File(packsRoot(context), pack.id), fileName)
            ?.takeIf { file -> file.isFile }
    }

    private fun readPack(directory: File, expectedId: String): StickerPackRecord? {
        return try {
            if (!directory.isDirectory || !safeIdPattern.matches(expectedId)) {
                return null
            }
            val manifestFile = File(directory, manifestFileName)
            if (!manifestFile.isFile) {
                return null
            }
            val payload = JSONObject(manifestFile.readText())
            val id = payload.optString("id").trim().lowercase()
            if (id != expectedId) {
                return null
            }

            val name = payload.optString("name").trim()
            val publisher = payload.optString("publisher").trim()
            val tray = payload.optString("tray").trim()
            val version = payload.optInt("version", 0)
            val animated = payload.optBoolean("animated", false)
            if (name.isEmpty() ||
                name.length > 128 ||
                publisher.isEmpty() ||
                publisher.length > 128 ||
                version < 1 ||
                !isSafeFileName(tray)
            ) {
                return null
            }
            if (resolveFile(directory, tray)?.isFile != true) {
                return null
            }

            val stickersArray = payload.optJSONArray("stickers") ?: return null
            if (stickersArray.length() !in 3..30) {
                return null
            }

            val seenFiles = HashSet<String>(stickersArray.length() + 1)
            seenFiles.add(tray)
            val stickers = ArrayList<StickerAsset>(stickersArray.length())
            for (index in 0 until stickersArray.length()) {
                val stickerObject = stickersArray.optJSONObject(index) ?: return null
                val stickerFileName = stickerObject.optString("file").trim()
                if (!isSafeFileName(stickerFileName) || !seenFiles.add(stickerFileName)) {
                    return null
                }
                if (resolveFile(directory, stickerFileName)?.isFile != true) {
                    return null
                }
                stickers.add(
                    StickerAsset(
                        fileName = stickerFileName,
                        emojis = sanitizeEmojis(stickerObject.optJSONArray("emojis")),
                        accessibilityText = stickerObject.optString("accessibilityText").trim(),
                    ),
                )
            }

            StickerPackRecord(
                id = id,
                name = name,
                publisher = publisher,
                animated = animated,
                trayFile = tray,
                version = version,
                stickers = stickers,
            )
        } catch (_: Exception) {
            null
        }
    }

    private fun sanitizeEmojis(value: JSONArray?): List<String> {
        if (value == null) {
            return emptyList()
        }
        val emojis = ArrayList<String>(3)
        for (index in 0 until value.length()) {
            val emoji = value.optString(index).trim()
            if (emoji.isNotEmpty() && !emojis.contains(emoji)) {
                emojis.add(emoji)
            }
            if (emojis.size == 3) {
                break
            }
        }
        return emojis
    }

    fun packsRoot(context: Context): File {
        return File(context.filesDir, packsDirectoryName)
    }

    private fun isSafeFileName(value: String): Boolean {
        if (value.isEmpty() || value.startsWith('.') || value.contains("..")) {
            return false
        }
        if (value.contains('/') || value.contains('\\')) {
            return false
        }
        return safeFilePattern.matches(value)
    }

    private fun resolveFile(root: File, relativeName: String): File? {
        if (!isSafeFileName(relativeName)) {
            return null
        }
        val canonicalRoot = root.canonicalFile
        val file = File(canonicalRoot, relativeName).canonicalFile
        return if (file.parentFile == canonicalRoot) file else null
    }
}
