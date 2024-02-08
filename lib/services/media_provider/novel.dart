import 'package:animo/models/abstract/provider_info.dart';
import 'package:animo/models/filter/multiselect_filter.dart';
import 'package:animo/models/filter/select_option.dart';
import 'package:animo/models/filter/select_filter.dart';

final novelTypes = [
  SelectOption('Light Novel', '2443'),
  SelectOption('Published Novel', '26874'),
  SelectOption('Web Novel', '2444'),
];
final novelLanguages = [
  SelectOption('Chinese', '495'),
  SelectOption('Filipino', '9181'),
  SelectOption('Indonesian', '9179'),
  SelectOption('Japanese', '496'),
  SelectOption('Khmer', '18657'),
  SelectOption('Korean', '497'),
  SelectOption('Malaysian', '9183'),
  SelectOption('Thai', '9954'),
  SelectOption('Vietnamese', '9177'),
];
final novelGenres = [
  SelectOption('Action', '8'),
  SelectOption('Adult', '280'),
  SelectOption('Adventure', '13'),
  SelectOption('Comedy', '17'),
  SelectOption('Drama', '9'),
  SelectOption('Ecchi', '292'),
  SelectOption('Fantasy', '5'),
  SelectOption('Gender Bender', '168'),
  SelectOption('Harem', '3'),
  SelectOption('Historical', '330'),
  SelectOption('Horror', '343'),
  SelectOption('Josei', '324'),
  SelectOption('Martial Arts', '14'),
  SelectOption('Mature', '4'),
  SelectOption('Mecha', '10'),
  SelectOption('Mystery', '245'),
  SelectOption('Psychological', '486'),
  SelectOption('Romance', '15'),
  SelectOption('School Life', '6'),
  SelectOption('Sci-fi', '11'),
  SelectOption('Seinen', '18'),
  SelectOption('Shoujo', '157'),
  SelectOption('Shoujo Ai', '851'),
  SelectOption('Shounen', '12'),
  SelectOption('Shounen Ai', '1692'),
  SelectOption('Slice of Life', '7'),
  SelectOption('Smut', '281'),
  SelectOption('Sports', '1357'),
  SelectOption('Supernatural', '16'),
  SelectOption('Tragedy', '132'),
  SelectOption('Wuxia', '479'),
  SelectOption('Xianxia', '480'),
  SelectOption('Xuanhuan', '3954'),
  SelectOption('Yaoi', '560'),
  SelectOption('Yuri', '922'),
];
final novelSorts = [
  SelectOption('Chapters', 'srel'),
  SelectOption('Frequency', 'sfrel'),
  SelectOption('Rank', 'srank'),
  SelectOption('Rating', 'srate'),
  SelectOption('Readers', 'sread'),
  SelectOption('Reviews', 'sreview'),
  SelectOption('Title', 'abc'),
  SelectOption('Last Updated', 'sdate'),
];
final novelStatuses = [
  SelectOption('All', '1'),
  SelectOption('Completed', '2'),
  SelectOption('Ongoing', '3'),
  SelectOption('Hiatus', '4'),
];
final novelOrder = [
  SelectOption('Ascending', 'asc'),
  SelectOption('Descending', 'desc'),
];

final novelInfo = ProviderInfo(
  name: 'Novel',
  mediaFilters: [
    SelectFilter('Status', 'ss', novelStatuses),
    SelectFilter('Sort', 'sort', novelSorts),
    SelectFilter('Order', 'order', novelOrder),
    MultiSelectFilter('Type', 'nt', novelTypes),
    MultiSelectFilter('Language', 'org', novelLanguages),
    MultiSelectFilter('Genres', 'gi', novelGenres),
  ],
);
