// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum MediaStatus {
  NOT_YET_RELEASED(Icons.upcoming, 'Not yet released', 'Not yet aired'),
  RELEASING(Icons.access_time, 'Releasing', 'Airing'),
  FINISHED(Icons.done_all, 'Finished', 'Finished'),
  CANCELLED(Icons.cancel, 'Cancelled', 'Cancelled'),
  HIATUS(Icons.hourglass_empty_rounded, 'Hiatus', 'Unknown');

  const MediaStatus(this.icon, this.manga, this.anime);

  final IconData icon;
  final String manga;
  final String anime;
}