import 'package:animo/utils/utils.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';

class MediaContent {
  final int? index;
  final String slug;
  final String? number;
  final String? parentNumber;
  final String? title;
  final String? lang;
  final DateTime? updatedAt;
  final String? group;

  MediaContent({
    this.index,
    required this.slug,
    this.number,
    this.parentNumber,
    this.title,
    this.lang,
    this.updatedAt,
    this.group,
  });

  String getTitle() {
    List<String> info = [];

    if (parentNumber != null) {
      info.add('Vol. $parentNumber');
    }
    if (number != null) {
      info.add('Ch. $number');
    }

    final String text = info.join(' ');

    info.clear();
    if (text.isNotEmpty) {
      info.add(text);
    }

    if (title != null) {
      info.add(title!);
    }

    return info.isEmpty ? 'Oneshot' : info.join(': ');
  }

  String getSubtitle() {
    final List<String> info = [];

    if (updatedAt != null) info.add(dateFormatter.format(updatedAt!));
    if (group != null) info.add(group!);

    return info.join(' • ');
  }

  Widget? getFlag() {
    return lang == null
        ? null
        : Flag.fromString(
            getCountryCode(lang!),
            height: 24,
            width: 24,
          );
  }

  MediaContent copyWith({
    int? index,
    String? slug,
    String? number,
    String? parentNumber,
    String? title,
    String? lang,
    DateTime? updatedAt,
    String? group,
  }) {
    return MediaContent(
      index: index ?? this.index,
      slug: slug ?? this.slug,
      number: number ?? this.number,
      parentNumber: parentNumber ?? this.parentNumber,
      title: title ?? this.title,
      lang: lang ?? this.lang,
      updatedAt: updatedAt ?? this.updatedAt,
      group: group ?? this.group,
    );
  }

  factory MediaContent.fromMap(Map<String, dynamic> map) {
    return MediaContent(
      slug: map['slug'] as String,
      number: map['number'] != null ? map['number'] as String : null,
      parentNumber:
          map['parentNumber'] != null ? map['parentNumber'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      lang: map['lang'] != null ? map['lang'] as String : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'] as String)
          : null,
      group: map['group'] != null ? map['group'] as String : null,
    );
  }

  @override
  String toString() {
    return 'MediaContent(slug: $slug, number: $number, parentNumber: $parentNumber, title: $title, lang: $lang, updatedAt: $updatedAt, group: $group)';
  }

  @override
  bool operator ==(covariant MediaContent other) {
    if (identical(this, other)) return true;

    return other.slug == slug &&
        other.number == number &&
        other.parentNumber == parentNumber &&
        other.title == title &&
        other.lang == lang &&
        other.updatedAt == updatedAt &&
        other.group == group;
  }

  @override
  int get hashCode {
    return slug.hashCode ^
        number.hashCode ^
        parentNumber.hashCode ^
        title.hashCode ^
        lang.hashCode ^
        updatedAt.hashCode ^
        group.hashCode;
  }
}
