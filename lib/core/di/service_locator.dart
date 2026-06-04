import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/editor/data/media_source.dart';
import '../../features/editor/data/image_editor.dart';
import '../../features/editor/data/sticker_processor.dart';
import '../../features/editor/data/webp_encoder.dart';
import '../../features/library/data/io/file_ops.dart';
import '../../features/library/data/io/json_store.dart';
import '../../features/library/data/io/library_dirs.dart';
import '../../features/library/data/native_webp_encoder.dart';
import '../../features/library/data/pack_exporter.dart';
import '../../features/library/data/pack_importer.dart';
import '../../features/library/data/pack_share_service.dart';
import '../../features/library/data/pack_store.dart';
import '../../features/library/domain/pack_validator.dart';
import '../../features/library/presentation/library_cubit.dart';
import '../../features/library/util/library_ids.dart';
import '../../features/store/data/store_mapper.dart';
import '../../features/store/data/store_remote_source.dart';
import '../../features/store/data/store_repository.dart';
import '../../features/store/presentation/store_cubit.dart';
import '../../features/whatsapp/whatsapp_stickers.dart';
import '../../features/whatsapp/data/whatsapp_channel.dart';
import '../config/appwrite_config.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> configureServiceLocator() async {
  if (serviceLocator.isRegistered<StoreRepository>()) {
    return;
  }

  serviceLocator
    ..registerLazySingleton<AppwriteConfig>(AppwriteConfig.fromEnvironment)
    ..registerLazySingleton<Dio>(() {
      final config = serviceLocator<AppwriteConfig>();
      return Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 45),
          sendTimeout: const Duration(seconds: 45),
          receiveDataWhenStatusError: true,
          responseType: ResponseType.json,
          headers: config.headers,
        ),
      );
    })
    ..registerLazySingleton(WhatsAppChannel.new)
    ..registerLazySingleton<FileOps>(FileOps.new)
    ..registerLazySingleton(() => JsonStore(serviceLocator<FileOps>()))
    ..registerLazySingleton(PackValidator.new)
    ..registerLazySingleton(
      () => LibraryDirs(() => serviceLocator<WhatsAppChannel>().packsRoot()),
    )
    ..registerLazySingleton(
      () => PackStore(
        serviceLocator<LibraryDirs>(),
        serviceLocator<FileOps>(),
        serviceLocator<JsonStore>(),
        serviceLocator<PackValidator>(),
      ),
    )
    ..registerLazySingleton(MediaSource.new)
    ..registerLazySingleton<ImageEditor>(() => const ProImageEditorAdapter())
    ..registerLazySingleton<WebpEncoder>(
      () => NativeWebpEncoder(serviceLocator<WhatsAppChannel>()),
    )
    ..registerLazySingleton(
      () => StickerProcessor(
        () => serviceLocator<LibraryDirs>().operation(
          LibraryIds.newOperationId(),
        ),
        serviceLocator<WebpEncoder>(),
      ),
    )
    ..registerLazySingleton(
      () => PackExporter(
        serviceLocator<LibraryDirs>(),
        serviceLocator<FileOps>(),
        serviceLocator<PackValidator>(),
      ),
    )
    ..registerLazySingleton(
      () => PackImporter(
        serviceLocator<LibraryDirs>(),
        serviceLocator<FileOps>(),
        serviceLocator<PackStore>(),
        serviceLocator<WhatsAppChannel>(),
      ),
    )
    ..registerLazySingleton(PackShareService.new)
    ..registerLazySingleton(
      () => WhatsAppStickers.withChannel(
        channel: serviceLocator<WhatsAppChannel>(),
      ),
    )
    ..registerLazySingleton(StoreMapper.new)
    ..registerLazySingleton<StoreRemoteSource>(
      () => AppwriteStoreRemoteSource(
        serviceLocator<Dio>(),
        serviceLocator<AppwriteConfig>(),
        serviceLocator<StoreMapper>(),
      ),
    )
    ..registerLazySingleton(
      () => StoreRepository(
        serviceLocator<StoreRemoteSource>(),
        serviceLocator<StoreMapper>(),
        serviceLocator<PackStore>(),
        serviceLocator<LibraryDirs>(),
        serviceLocator<FileOps>(),
        serviceLocator<JsonStore>(),
        serviceLocator<PackValidator>(),
        serviceLocator<WebpEncoder>(),
      ),
    )
    ..registerFactory(
      () => StoreCubit(
        serviceLocator<StoreRepository>(),
        serviceLocator<StoreMapper>(),
      ),
    )
    ..registerFactory(
      () => LibraryCubit(
        serviceLocator<PackStore>(),
        serviceLocator<WhatsAppStickers>(),
        serviceLocator<PackExporter>(),
        serviceLocator<PackImporter>(),
        serviceLocator<PackShareService>(),
      ),
    );
}
