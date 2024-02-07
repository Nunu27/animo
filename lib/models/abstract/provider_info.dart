import 'package:animo/models/abstract/filter.dart';

class ProviderInfo {
  final String name;
  final List<Filter> mediaFilters;
  final List<Filter>? contentFilters;
  final bool haveGroupFilter;
  final bool useFetchGroup;

  ProviderInfo({
    required this.name,
    required this.mediaFilters,
    this.contentFilters,
    this.haveGroupFilter = true,
    this.useFetchGroup = false,
  });
}
