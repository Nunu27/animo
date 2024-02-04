enum TrailerSite {
  youtube,
  dailymotion;

  String getEmbedUrl(String id) {
    switch (this) {
      case TrailerSite.youtube:
        return 'https://www.youtube.com/embed/$id?enablejsapi=1&wmode=opaque&autoplay=1';
      case TrailerSite.dailymotion:
        return 'https://www.dailymotion.com/embed/video/$id?autoplay=1';
    }
  }
}

class MediaTrailer {
  final String id;
  final TrailerSite site;
  final String thumbnail;

  MediaTrailer({required this.id, required this.site, required this.thumbnail});

  String getEmbedUrl() {
    return site.getEmbedUrl(id);
  }
}
