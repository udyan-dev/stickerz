import 'package:share_plus/share_plus.dart';

import '../../../core/error/app_error.dart';
import '../../../core/error/app_result.dart';
import '../../../core/util/constants/constants.dart';

class PackShareService {
  Future<AppResult<void>> share(String archivePath) async {
    try {
      final result = await SharePlus.instance.share(
        ShareParams(
          text: PackFiles.operationExportText,
          files: <XFile>[
            XFile(archivePath, mimeType: PackFiles.archiveMimeType),
          ],
        ),
      );
      if (result.status == ShareResultStatus.dismissed) {
        return const AppResult.failure(AppError.cancelled());
      }
      return const AppResult.success(null);
    } on Object catch (error) {
      return AppResult.failure(
        AppError.platform(
          message: PackMessages.shareFailed,
          debugDetails: error.toString(),
        ),
      );
    }
  }
}
