import 'package:animo/data/repositories/meta/constants/meta_filter_constants.dart';
import 'package:animo/domain/entities/filter/filter.dart';
import 'package:animo/domain/enums/media_format.dart';
import 'package:animo/domain/enums/media_season.dart';
import 'package:animo/domain/enums/media_source.dart';
import 'package:animo/domain/enums/media_status.dart';
import 'package:animo/domain/enums/media_type.dart';

final animeFilters = <Filter>[
  FilterMultiSelect(
      'Genres',
      'genres',
      Map.fromEntries(MetaFilterConstants.genres.map(
        (genre) => MapEntry(genre, genre),
      ))),
  FilterSelect(
    'Season',
    'season',
    Map.fromEntries(
      MediaSeason.values.map(
        (season) => MapEntry(season.name, season.text),
      ),
    ),
  ),
  FilterSelect(
    'Source Material',
    'source',
    Map.fromEntries(
      MediaSource.values.map(
        (source) => MapEntry(source.name, source.text),
      ),
    ),
  ),
  const FilterSelect(
    'Country Of Origin',
    'countryOfOrigin',
    MetaFilterConstants.countries,
  ),
  FilterSelect(
    'Airing Status',
    'status',
    Map.fromEntries(
      MediaStatus.values
          .where((status) => status.anime != null)
          .map((status) => MapEntry(status.name, status.anime!)),
    ),
  ),
  FilterMultiSelect(
    'Format',
    'format',
    Map.fromEntries(
      MediaFormat.values
          .where((format) => format.type == MediaType.ANIME)
          .map((format) => MapEntry(format.name, format.text)),
    ),
  ),
  const FilterRange('Year Range', 'year'),
  const FilterRange('Episode Range', 'episode'),
  const FilterRange('Duration Range', 'duration'),
  const FilterCheckbox('Adult', 'isAdult'),
];
