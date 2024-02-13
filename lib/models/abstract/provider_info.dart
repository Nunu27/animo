import 'package:animo/models/abstract/filter.dart';
import 'package:animo/models/abstract/media_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProviderInfo {
  final String name;
  final List<Filter> mediaFilters;
  final List<Filter>? contentFilters;
  final bool haveGroupFilter;
  final bool useFetchGroup;
  final AutoDisposeProvider<MediaProvider>? provider;

  ProviderInfo({
    required this.name,
    required this.mediaFilters,
    this.contentFilters,
    this.haveGroupFilter = true,
    this.useFetchGroup = false,
    this.provider,
  });
}
