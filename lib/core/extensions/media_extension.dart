import 'package:animo/domain/entities/media/media.dart';
import 'package:animo/domain/entities/media/media_basic.dart';

extension MediaExtension on Media {
  MediaBasic toMediaBasic() {
    return MediaBasic(
      id: id,
      cover: cover,
      title: title,
      type: type,
    );
  }
}
