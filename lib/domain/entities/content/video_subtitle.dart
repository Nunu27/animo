import 'package:equatable/equatable.dart';

class VideoSubtitle extends Equatable {
  final String label;
  final String file;

  const VideoSubtitle({required this.label, required this.file,});

  @override
  List<Object> get props => [label, file];
}
