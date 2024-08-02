import 'package:animo/domain/enums/media_format.dart';
import 'package:animo/domain/enums/media_type.dart';

mixin FilterMixin {
  Map<String, dynamic> getDefaultOptions(MediaType type) {
    return switch (type) {
      MediaType.ANIME => {
          'type': type.name,
        },
      MediaType.MANGA => {
          'type': type.name,
          'excludedFormat': [MediaFormat.NOVEL.name],
        },
      MediaType.NOVEL => {
          'type': MediaType.MANGA.name,
          'format': [MediaFormat.NOVEL.name],
        },
    };
  }
}
