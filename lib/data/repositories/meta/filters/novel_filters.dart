import 'package:animo/data/repositories/meta/constants/meta_filter_constants.dart';
import 'package:animo/domain/entities/filter/filter.dart';
import 'package:animo/domain/enums/media_source.dart';
import 'package:animo/domain/enums/media_status.dart';

final novelFilters = <Filter>[
  FilterMultiSelect(
      'Genres',
      'genres',
      Map.fromEntries(MetaFilterConstants.genres.map(
        (genre) => MapEntry(genre, genre),
      ))),
  FilterSelect(
    'Source Material',
    'source',
    Map.fromEntries(
      MediaSource.values.map(
        (source) => MapEntry(source.name, source.text),
      ),
    ),
  ),
  FilterSelect(
    'Publishing Status',
    'status',
    Map.fromEntries(
      MediaStatus.values
          .where((status) => status.manga != null)
          .map((status) => MapEntry(status.name, status.manga!)),
    ),
  ),
  const FilterRange(
    'Year Range',
    'year',
  ),
  const FilterRange('Chapter Range', 'chapter'),
  const FilterRange('Volume Range', 'volume'),
  const FilterCheckbox('Adult', 'isAdult'),
];
