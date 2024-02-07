// ignore_for_file: public_member_api_docs, sort_constructors_first
class VideoSubtitle {
  final String label;
  final String file;

  VideoSubtitle({required this.label, required this.file});

  @override
  String toString() => 'VideoSubtitle(label: $label, file: $file)';
}
