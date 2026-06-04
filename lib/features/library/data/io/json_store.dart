import 'dart:convert';
import 'dart:io';

import '../../../../core/util/constants/constants.dart';
import 'file_ops.dart';

class JsonStore {
  const JsonStore(this._fileOps);

  final FileOps _fileOps;

  Future<Map<String, dynamic>> readMap(String path) async {
    final decoded = jsonDecode(await File(path).readAsString());
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException(PackMessages.expectedJsonObject);
    }
    return decoded;
  }

  Future<void> writeMap(String path, Map<String, dynamic> value) {
    final json = const JsonEncoder.withIndent(
      PackFiles.fileIndent,
    ).convert(value);
    return _fileOps.writeStringAtomic(path, '$json${PackFiles.newline}');
  }
}
