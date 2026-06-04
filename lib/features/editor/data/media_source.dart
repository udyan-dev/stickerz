import 'package:image_picker/image_picker.dart';

import '../../../core/error/app_error.dart';
import '../../../core/error/app_result.dart';
import '../../../core/util/constants/constants.dart';

class MediaSource {
  MediaSource([ImagePicker? picker]) : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  Future<AppResult<String>> pickImage({
    ImageSource source = ImageSource.gallery,
  }) async {
    try {
      final file = await _picker.pickImage(source: source);
      if (file == null) {
        return const AppResult.failure(AppError.cancelled());
      }
      return AppResult.success(file.path);
    } on Object catch (error) {
      return AppResult.failure(
        AppError.platform(
          message: EditorMessages.imageSelectionFailed,
          debugDetails: error.toString(),
        ),
      );
    }
  }
}
