import 'package:animo/models/filter/input_filter.dart';
import 'package:animo/models/filter/multiselect_filter.dart';
import 'package:animo/models/filter/select_option.dart';
import 'package:animo/models/filter/select_filter.dart';

final animeTypes = [
  SelectOption('All', null),
  SelectOption('Movie', '1'),
  SelectOption('TV', '2'),
  SelectOption('OVA', '3'),
  SelectOption('ONA', '4'),
  SelectOption('Special', '5'),
  SelectOption('Music', '6'),
];
final animeStatuses = [
  SelectOption('All', null),
  SelectOption('Finished Airing', '1'),
  SelectOption('Currently Airing', '2'),
  SelectOption('Not yet aired', '3'),
];
final animeRatings = [
  SelectOption('All', null),
  SelectOption('G', '1'),
  SelectOption('PG', '2'),
  SelectOption('PG-13', '3'),
  SelectOption('R', '4'),
  SelectOption('R+', '5'),
  SelectOption('Rx', '6'),
];
final animeScores = [
  SelectOption('All', null),
  SelectOption('Appalling', '1'),
  SelectOption('Horrible', '2'),
  SelectOption('Very Bad', '3'),
  SelectOption('Bad', '4'),
  SelectOption('Average', '5'),
  SelectOption('Fine', '6'),
  SelectOption('Good', '7'),
  SelectOption('Very Good', '8'),
  SelectOption('Great', '9'),
  SelectOption('Masterpiece', '10'),
];
final animeSeasons = [
  SelectOption('All', null),
  SelectOption('Spring', '1'),
  SelectOption('Summer', '2'),
  SelectOption('Fall', '3'),
  SelectOption('Winter', '4'),
];
final animeLanguages = [
  SelectOption('All', null),
  SelectOption('SUB', '1'),
  SelectOption('DUB', '2'),
  SelectOption('SUB & DUB', '3'),
];
final animeSorts = [
  SelectOption('Default', 'default'),
  SelectOption('Recently Added', 'recently_added'),
  SelectOption('Recently Updated', 'recently_updated'),
  SelectOption('Score', 'score'),
  SelectOption('Name A-Z', 'name_az'),
  SelectOption('Released Date', 'released_date'),
  SelectOption('Most Watched', 'most_watched'),
];
final animeGenres = [
  SelectOption('Action', '1'),
  SelectOption('Adventure', '2'),
  SelectOption('Cars', '3'),
  SelectOption('Comedy', '4'),
  SelectOption('Dementia', '5'),
  SelectOption('Demons', '6'),
  SelectOption('Drama', '8'),
  SelectOption('Ecchi', '9'),
  SelectOption('Fantasy', '10'),
  SelectOption('Game', '11'),
  SelectOption('Harem', '35'),
  SelectOption('Historical', '13'),
  SelectOption('Horror', '14'),
  SelectOption('Isekai', '44'),
  SelectOption('Josei', '43'),
  SelectOption('Kids', '15'),
  SelectOption('Magic', '16'),
  SelectOption('Martial Arts', '17'),
  SelectOption('Mecha', '18'),
  SelectOption('Military', '38'),
  SelectOption('Music', '19'),
  SelectOption('Mystery', '7'),
  SelectOption('Parody', '20'),
  SelectOption('Police', '39'),
  SelectOption('Psychological', '40'),
  SelectOption('Romance', '22'),
  SelectOption('Samurai', '21'),
  SelectOption('School', '23'),
  SelectOption('Sci-Fi', '24'),
  SelectOption('Seinen', '42'),
  SelectOption('Shoujo', '25'),
  SelectOption('Shoujo Ai', '26'),
  SelectOption('Shounen', '27'),
  SelectOption('Shounen Ai', '28'),
  SelectOption('Slice of Life', '36'),
  SelectOption('Space', '29'),
  SelectOption('Sports', '30'),
  SelectOption('Super Power', '31'),
  SelectOption('Supernatural', '37'),
  SelectOption('Thriller', '41'),
  SelectOption('Vampire', '32'),
];

final animeMediaOptions = [
  MultiSelectFilter('Genres', 'genres', animeGenres),
  SelectFilter('Type', 'type', animeTypes),
  SelectFilter('Status', 'status', animeStatuses),
  SelectFilter('Rated', 'rated', animeRatings),
  SelectFilter('Score', 'score', animeScores),
  SelectFilter('Season', 'season', animeSeasons),
  SelectFilter('Language', 'language', animeLanguages),
  InputFilter('From', 'sy', title: 'From year, ex: 2010'),
  InputFilter('To', 'ey', title: 'To year, ex: 2021'),
  SelectFilter('Sort', 'sort', animeSorts),
];
