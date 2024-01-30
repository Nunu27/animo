class MediaContent {
  final String slug;
  final String number;
  final String? title;
  final String? lang;
  final DateTime? updatedAt;
  final String? group;

  MediaContent({
    required this.slug,
    required this.number,
    this.title,
    this.lang,
    this.updatedAt,
    this.group,
  });

  @override
  bool operator ==(covariant MediaContent other) {
    if (identical(this, other)) return true;

    return other.slug == slug &&
        other.number == number &&
        other.title == title &&
        other.lang == lang &&
        other.updatedAt == updatedAt &&
        other.group == group;
  }

  @override
  int get hashCode {
    return slug.hashCode ^
        number.hashCode ^
        title.hashCode ^
        lang.hashCode ^
        updatedAt.hashCode ^
        group.hashCode;
  }
}
