import 'package:animo/models/filter_options/input_option.dart';
import 'package:animo/models/filter_options/multiselect_option.dart';
import 'package:animo/models/filter_options/select_item.dart';
import 'package:animo/models/filter_options/select_option.dart';

final animeTypes = [
  SelectItem('All', null),
  SelectItem('Movie', '1'),
  SelectItem('TV', '2'),
  SelectItem('OVA', '3'),
  SelectItem('ONA', '4'),
  SelectItem('Special', '5'),
  SelectItem('Music', '6'),
];

final animeStatuses = [
  SelectItem('All', null),
  SelectItem('Finished Airing', '1'),
  SelectItem('Currently Airing', '2'),
  SelectItem('Not yet aired', '3'),
];

final animeRatings = [
  SelectItem('All', null),
  SelectItem('G', '1'),
  SelectItem('PG', '2'),
  SelectItem('PG-13', '3'),
  SelectItem('R', '4'),
  SelectItem('R+', '5'),
  SelectItem('Rx', '6'),
];

final animeScores = [
  SelectItem('All', null),
  SelectItem('Appalling', '1'),
  SelectItem('Horrible', '2'),
  SelectItem('Very Bad', '3'),
  SelectItem('Bad', '4'),
  SelectItem('Average', '5'),
  SelectItem('Fine', '6'),
  SelectItem('Good', '7'),
  SelectItem('Very Good', '8'),
  SelectItem('Great', '9'),
  SelectItem('Masterpiece', '10'),
];

final animeSeasons = [
  SelectItem('All', null),
  SelectItem('Spring', '1'),
  SelectItem('Summer', '2'),
  SelectItem('Fall', '3'),
  SelectItem('Winter', '4'),
];

final animeLanguages = [
  SelectItem('All', null),
  SelectItem('SUB', '1'),
  SelectItem('DUB', '2'),
  SelectItem('SUB & DUB', '3'),
];

final animeSorts = [
  SelectItem('Default', 'default'),
  SelectItem('Recently Added', 'recently_added'),
  SelectItem('Recently Updated', 'recently_updated'),
  SelectItem('Score', 'score'),
  SelectItem('Name A-Z', 'name_az'),
  SelectItem('Released Date', 'released_date'),
  SelectItem('Most Watched', 'most_watched'),
];

final animeGenres = [
  SelectItem('Action', '1'),
  SelectItem('Adventure', '2'),
  SelectItem('Cars', '3'),
  SelectItem('Comedy', '4'),
  SelectItem('Dementia', '5'),
  SelectItem('Demons', '6'),
  SelectItem('Drama', '8'),
  SelectItem('Ecchi', '9'),
  SelectItem('Fantasy', '10'),
  SelectItem('Game', '11'),
  SelectItem('Harem', '35'),
  SelectItem('Historical', '13'),
  SelectItem('Horror', '14'),
  SelectItem('Isekai', '44'),
  SelectItem('Josei', '43'),
  SelectItem('Kids', '15'),
  SelectItem('Magic', '16'),
  SelectItem('Martial Arts', '17'),
  SelectItem('Mecha', '18'),
  SelectItem('Military', '38'),
  SelectItem('Music', '19'),
  SelectItem('Mystery', '7'),
  SelectItem('Parody', '20'),
  SelectItem('Police', '39'),
  SelectItem('Psychological', '40'),
  SelectItem('Romance', '22'),
  SelectItem('Samurai', '21'),
  SelectItem('School', '23'),
  SelectItem('Sci-Fi', '24'),
  SelectItem('Seinen', '42'),
  SelectItem('Shoujo', '25'),
  SelectItem('Shoujo Ai', '26'),
  SelectItem('Shounen', '27'),
  SelectItem('Shounen Ai', '28'),
  SelectItem('Slice of Life', '36'),
  SelectItem('Space', '29'),
  SelectItem('Sports', '30'),
  SelectItem('Super Power', '31'),
  SelectItem('Supernatural', '37'),
  SelectItem('Thriller', '41'),
  SelectItem('Vampire', '32'),
];

final animeOptions = [
  MultiSelectOption('Genres', 'genres', animeGenres),
  SelectOption('Type', 'type', animeTypes),
  SelectOption('Status', 'status', animeStatuses),
  SelectOption('Rated', 'rated', animeRatings),
  SelectOption('Score', 'score', animeScores),
  SelectOption('Season', 'season', animeSeasons),
  SelectOption('Language', 'language', animeLanguages),
  InputOption('From', 'sy', title: 'From year, ex: 2010'),
  InputOption('To', 'ey', title: 'To year, ex: 2021'),
  SelectOption('Sort', 'sort', animeSorts),
];
