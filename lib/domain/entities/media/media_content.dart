import 'package:animo/domain/enums/media_type.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class MediaContent extends Equatable {
  final int? index;
  final String slug;
  final String? number;
  final String? parentNumber;
  final String? title;
  final String? lang;
  final DateTime? updatedAt;
  final String? group;

  const MediaContent({
    this.index,
    required this.slug,
    this.number,
    this.parentNumber,
    this.title,
    this.lang,
    this.updatedAt,
    this.group,
  });

  String getSimpleTitle({MediaType type = MediaType.MANGA}) {
    if (number != null) {
      return '${type == MediaType.ANIME ? 'Episode' : 'Chapter'} $number';
    } else if (parentNumber != null) {
      return 'Volume $parentNumber';
    } else if (title != null) {
      return title!;
    } else {
      return 'Oneshot';
    }
  }

  String getTitle({MediaType type = MediaType.MANGA}) {
    List<String> info = [];

    if (parentNumber != null) {
      info.add('Vol. $parentNumber');
    }
    if (number != null) {
      info.add('${type == MediaType.ANIME ? 'Ep.' : 'Ch.'} $number');
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

    if (updatedAt != null) {
      info.add(DateFormat('yyyy/MM/dd').format(updatedAt!));
    }
    if (group != null) info.add(group!);

    return info.join(' • ');
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

  factory MediaContent.fromMap(Map<String, dynamic> map, {int? index}) {
    return MediaContent(
      index: index,
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
  List<Object?> get props => [
        index,
        slug,
        number,
        parentNumber,
        title,
        lang,
        updatedAt,
        group,
      ];
}
