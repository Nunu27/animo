import 'package:animo/domain/entities/media/media_basic.dart';

abstract class MediaRepository {
  List<MediaBasic> search(query);
  List<MediaBasic> getMediaContents();
}
