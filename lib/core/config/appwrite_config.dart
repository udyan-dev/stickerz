import 'environment.dart';
import '../util/constants/constants.dart';

class AppwriteConfig {
  factory AppwriteConfig.fromEnvironment() {
    final endpoint = Uri.tryParse(Environment.appwritePublicEndpoint);
    if (endpoint == null) {
      throw StateError(AppwriteConstants.invalidEndpointUri);
    }
    return AppwriteConfig(
      projectId: Environment.appwriteProjectId,
      projectName: Environment.appwriteProjectName,
      endpoint: endpoint,
      bucketId: Environment.appwriteBucketId,
      catalogFileId: Environment.catalogIndexFileId,
    );
  }

  AppwriteConfig({
    required String projectId,
    required String projectName,
    required Uri endpoint,
    required String bucketId,
    required String catalogFileId,
  }) : projectId = _requireAppwriteValue(
         projectId,
         name: AppwriteConstants.fieldProjectId,
       ),
       projectName = _requireAppwriteValue(
         projectName,
         name: AppwriteConstants.fieldProjectName,
       ),
       endpoint = _normalizeAppwriteEndpoint(endpoint),
       bucketId = _requireAppwriteValue(
         bucketId,
         name: AppwriteConstants.fieldBucketId,
       ),
       catalogFileId = _requireAppwriteValue(
         catalogFileId,
         name: AppwriteConstants.fieldCatalogFileId,
       ),
       headers = Map<String, String>.unmodifiable(<String, String>{
         AppwriteConstants.headerProject: _requireAppwriteValue(
           projectId,
           name: AppwriteConstants.fieldProjectId,
         ),
         AppwriteConstants.headerResponseFormat:
             AppwriteConstants.responseFormatVersion,
       }),
       _projectQueryParameters =
           Map<String, String>.unmodifiable(<String, String>{
             AppwriteConstants.queryProject: _requireAppwriteValue(
               projectId,
               name: AppwriteConstants.fieldProjectId,
             ),
           }),
       _storagePathSegments = List<String>.unmodifiable(<String>[
         ..._normalizeAppwriteEndpoint(
           endpoint,
         ).pathSegments.where((segment) => segment.isNotEmpty),
         AppwriteConstants.pathStorage,
         AppwriteConstants.pathBuckets,
         _requireAppwriteValue(bucketId, name: AppwriteConstants.fieldBucketId),
       ]);

  final String projectId;
  final String projectName;
  final Uri endpoint;
  final String bucketId;
  final String catalogFileId;
  final Map<String, String> headers;
  final Map<String, String> _projectQueryParameters;
  final List<String> _storagePathSegments;

  Uri get catalogDownloadUri => storageDownloadUri(catalogFileId);

  Uri storageFileUri(String fileId) {
    final normalized = _normalizedFileId(fileId);
    return endpoint.replace(
      pathSegments: <String>[
        ..._storagePathSegments,
        AppwriteConstants.pathFiles,
        normalized,
      ],
      queryParameters: _projectQueryParameters,
    );
  }

  Uri storageDownloadUri(String fileId) {
    final normalized = _normalizedFileId(fileId);
    return endpoint.replace(
      pathSegments: <String>[
        ..._storagePathSegments,
        AppwriteConstants.pathFiles,
        normalized,
        AppwriteConstants.pathDownload,
      ],
      queryParameters: _projectQueryParameters,
    );
  }

  Uri storageViewUri(String fileId) {
    final normalized = _normalizedFileId(fileId);
    return endpoint.replace(
      pathSegments: <String>[
        ..._storagePathSegments,
        AppwriteConstants.pathFiles,
        normalized,
        AppwriteConstants.pathView,
      ],
      queryParameters: _projectQueryParameters,
    );
  }

  String _normalizedFileId(String value) {
    return _requireAppwriteValue(
      value.trim(),
      name: AppwriteConstants.fieldFileId,
    );
  }
}

Uri _normalizeAppwriteEndpoint(Uri endpoint) {
  if (!endpoint.hasScheme || endpoint.host.isEmpty) {
    throw StateError(AppwriteConstants.endpointMustBeAbsolute);
  }
  final normalizedPath = endpoint.path.endsWith('/')
      ? endpoint.path.substring(0, endpoint.path.length - 1)
      : endpoint.path;
  return endpoint.replace(path: normalizedPath);
}

String _requireAppwriteValue(String value, {required String name}) {
  if (value.trim().isEmpty) {
    throw StateError(AppwriteConstants.missingValue(name));
  }
  return value.trim();
}
