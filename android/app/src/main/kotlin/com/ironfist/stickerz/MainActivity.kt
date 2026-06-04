package com.ironfist.stickerz

import android.content.Intent
import android.net.Uri
import com.ironfist.stickerz.sticker.StickerBridge
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import java.io.File

class MainActivity : FlutterActivity() {
    private lateinit var stickerBridge: StickerBridge
    private var pendingImportUri: String? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        stickerBridge = StickerBridge(
            this,
            ::takePendingImportUri,
            ::copyImportUri,
        )
        stickerBridge.configure(flutterEngine.dartExecutor.binaryMessenger)
        captureImportIntent(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        captureImportIntent(intent)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (::stickerBridge.isInitialized &&
            stickerBridge.onActivityResult(requestCode, resultCode, data)
        ) {
            return
        }
        super.onActivityResult(requestCode, resultCode, data)
    }

    private fun captureImportIntent(intent: Intent?) {
        if (intent?.action != Intent.ACTION_VIEW) {
            return
        }
        pendingImportUri = intent.data?.toString()
    }

    private fun takePendingImportUri(): String? {
        val uri = pendingImportUri
        pendingImportUri = null
        return uri
    }

    private fun copyImportUri(rawUri: String): String? {
        return try {
            val uri = Uri.parse(rawUri)
            val input = contentResolver.openInputStream(uri) ?: return null
            val directory = File(cacheDir, "imports")
            if (!directory.exists() && !directory.mkdirs()) {
                return null
            }
            val output = File(directory, "import_${System.nanoTime()}.wspack")
            input.use { source ->
                output.outputStream().use { destination ->
                    source.copyTo(destination)
                }
            }
            output.absolutePath
        } catch (_: Exception) {
            null
        }
    }
}
