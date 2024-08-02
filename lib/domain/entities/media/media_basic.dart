import 'package:animo/domain/enums/media_type.dart';
import 'package:equatable/equatable.dart';

class MediaBasic extends Equatable {
  final int id;
  final String cover;
  final String title;
  final MediaType type;
  final String? info;

  const MediaBasic({
    required this.id,
    required this.cover,
    required this.title,
    required this.type,
    this.info,
  });

  @override
  List<Object?> get props => [id, cover, title, type, info];
}
