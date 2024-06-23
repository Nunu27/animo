import 'package:animo/domain/entities/media/media_basic.dart';
import 'package:equatable/equatable.dart';

class Feed extends Equatable {
  final List<MediaBasic> carousel;
  final List<MediaBasic> trending;
  final List<MediaBasic> popularThisSeason;
  final List<MediaBasic> upcoming;

  const Feed({
    required this.carousel,
    required this.trending,
    required this.popularThisSeason,
    required this.upcoming,
  });

  @override
  List<Object> get props => [carousel, trending, popularThisSeason, upcoming];
}
