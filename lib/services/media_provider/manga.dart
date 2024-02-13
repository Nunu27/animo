import 'package:animo/models/abstract/provider_info.dart';
import 'package:animo/models/filter/input_filter.dart';
import 'package:animo/models/filter/multiselect_filter.dart';
import 'package:animo/models/filter/select_option.dart';
import 'package:animo/models/filter/select_filter.dart';
import 'package:animo/services/media_provider/manga/manga_provider.dart';

final mangaGenres = [
  SelectOption('4-Koma', '4-koma'),
  SelectOption('Action', 'action'),
  SelectOption('Adaptation', 'adaptation'),
  SelectOption('Adult', 'adult'),
  SelectOption('Adventure', 'adventure'),
  SelectOption('Aliens', 'aliens'),
  SelectOption('Animals', 'animals'),
  SelectOption('Anthology', 'anthology'),
  SelectOption('Award Winning', 'award-winning'),
  SelectOption('Comedy', 'comedy'),
  SelectOption('Cooking', 'cooking'),
  SelectOption('Crime', 'crime'),
  SelectOption('Crossdressing', 'crossdressing'),
  SelectOption('Delinquents', 'delinquents'),
  SelectOption('Demons', 'demons'),
  SelectOption('Doujinshi', 'doujinshi'),
  SelectOption('Drama', 'drama'),
  SelectOption('Ecchi', 'ecchi'),
  SelectOption('Fan Colored', 'fan-colored'),
  SelectOption('Fantasy', 'fantasy'),
  SelectOption('Full Color', 'full-color'),
  SelectOption('Gender Bender', 'gender-bender'),
  SelectOption('Genderswap', 'genderswap'),
  SelectOption('Ghosts', 'ghosts'),
  SelectOption('Gore', 'gore'),
  SelectOption('Gyaru', 'gyaru'),
  SelectOption('Harem', 'harem'),
  SelectOption('Historical', 'historical'),
  SelectOption('Horror', 'horror'),
  SelectOption('Incest', 'incest'),
  SelectOption('Isekai', 'isekai'),
  SelectOption('Loli', 'loli'),
  SelectOption('Long Strip', 'long-strip'),
  SelectOption('Mafia', 'mafia'),
  SelectOption('Magic', 'magic'),
  SelectOption('Magical Girls', 'magical-girls'),
  SelectOption('Martial Arts', 'martial-arts'),
  SelectOption('Mature', 'mature'),
  SelectOption('Mecha', 'mecha'),
  SelectOption('Medical', 'medical'),
  SelectOption('Military', 'military'),
  SelectOption('Monster Girls', 'monster-girls'),
  SelectOption('Monsters', 'monsters'),
  SelectOption('Music', 'music'),
  SelectOption('Mystery', 'mystery'),
  SelectOption('Ninja', 'ninja'),
  SelectOption('Office Workers', 'office-workers'),
  SelectOption('Official Colored', 'official-colored'),
  SelectOption('Oneshot', 'oneshot'),
  SelectOption('Philosophical', 'philosophical'),
  SelectOption('Police', 'police'),
  SelectOption('Post-Apocalyptic', 'post-apocalyptic'),
  SelectOption('Psychological', 'psychological'),
  SelectOption('Reincarnation', 'reincarnation'),
  SelectOption('Reverse Harem', 'reverse-harem'),
  SelectOption('Romance', 'romance'),
  SelectOption('Samurai', 'samurai'),
  SelectOption('School Life', 'school-life'),
  SelectOption('Sci-Fi', 'sci-fi'),
  SelectOption('Sexual Violence', 'sexual-violence'),
  SelectOption('Shota', 'shota'),
  SelectOption('Shoujo Ai', 'shoujo-ai'),
  SelectOption('Shounen Ai', 'shounen-ai'),
  SelectOption('Slice of Life', 'slice-of-life'),
  SelectOption('Smut', 'smut'),
  SelectOption('Sports', 'sports'),
  SelectOption('Superhero', 'superhero'),
  SelectOption('Supernatural', 'supernatural'),
  SelectOption('Survival', 'survival'),
  SelectOption('Thriller', 'thriller'),
  SelectOption('Time Travel', 'time-travel'),
  SelectOption('Traditional Games', 'traditional-games'),
  SelectOption('Tragedy', 'tragedy'),
  SelectOption('User Created', 'user-created'),
  SelectOption('Vampires', 'vampires'),
  SelectOption('Video Games', 'video-games'),
  SelectOption('Villainess', 'villainess'),
  SelectOption('Virtual Reality', 'virtual-reality'),
  SelectOption('Web Comic', 'web-comic'),
  SelectOption('Wuxia', 'wuxia'),
  SelectOption('Yaoi', 'yaoi'),
  SelectOption('Yuri', 'yuri'),
  SelectOption('Zombies', 'zombies'),
];
final mangaDemographics = [
  SelectOption('Shounen', '1'),
  SelectOption('Shoujo', '2'),
  SelectOption('Seinen', '3'),
  SelectOption('Josei', '4'),
];
final mangaCreatedAts = [
  SelectOption('3 days ago', '3'),
  SelectOption('7 days ago', '7'),
  SelectOption('30 days ago', '30'),
  SelectOption('3 months ago', '90'),
  SelectOption('6 months ago', '180'),
  SelectOption('1 year ago', '365'),
  SelectOption('2 years ago', '730'),
];
final mangaTypes = [
  SelectOption('Manga', 'jp'),
  SelectOption('Manhwa', 'kr'),
  SelectOption('Manhua', 'cn'),
  SelectOption('others', 'others'),
];
final mangaStatuses = [
  SelectOption('All', null),
  SelectOption('Ongoing', '1'),
  SelectOption('Completed', '2'),
  SelectOption('Cancelled', '3'),
  SelectOption('Hiatus', '4'),
];
final mangaSorts = [
  SelectOption('Latest', 'created_at'),
  SelectOption('Last updated', 'uploaded'),
  SelectOption('High rating', 'rating'),
  SelectOption('Popular', 'user_follow_count')
];

final mangaContentSorts = [
  SelectOption('Chapter (desc)', '0', key: 'chap-order'),
  SelectOption('Chapter (asc)', '1', key: 'chap-order'),
  SelectOption('Date (desc)', '0', key: 'date-order'),
  SelectOption('Date (asc)', '1', key: 'date-order'),
];

final mangaInfo = ProviderInfo(
  name: 'Manga',
  mediaFilters: [
    InputFilter('From', 'from', title: 'From year, ex: 2010'),
    InputFilter('To', 'to', title: 'To year, ex: 2021'),
    InputFilter('Minimum chapters', 'minimum'),
    SelectFilter('Created at', 'time', mangaCreatedAts),
    SelectFilter('Status', 'status', mangaStatuses),
    SelectFilter('Sort', 'sort', mangaSorts),
    MultiSelectFilter('Genres', 'genres', mangaGenres),
    MultiSelectFilter('Demographic', 'demographic', mangaDemographics),
    MultiSelectFilter('Type', 'country', mangaTypes),
  ],
  contentFilters: [
    SelectFilter('Sort', 'sort', mangaContentSorts),
  ],
  useFetchGroup: false,
  provider: mangaProvider,
);
