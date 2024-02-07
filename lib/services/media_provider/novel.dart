import 'package:animo/models/abstract/provider_info.dart';
import 'package:animo/models/filter/multiselect_filter.dart';
import 'package:animo/models/filter/select_option.dart';
import 'package:animo/models/filter/select_filter.dart';

final novelTypes = [
  SelectOption('Light Novel', '2443'),
  SelectOption('Published Novel', '26874'),
  SelectOption('Web Novel', '2444'),
];

final novelInfo = ProviderInfo(name: 'Novel', mediaFilters: [
  MultiSelectFilter('Genres', 'nt', novelTypes),
  MultiSelectFilter('Type', 'nt', novelTypes),
  MultiSelectFilter('Language', 'nt', novelTypes),
  SelectFilter('Status', 'nt', novelTypes),
  SelectFilter('Sort', 'nt', novelTypes),
  SelectFilter('Order', 'nt', novelTypes),
]);
