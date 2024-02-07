import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:animo/models/abstract/video_extractor.dart';
import 'package:animo/models/content/video_data.dart';
import 'package:animo/models/content/video_source.dart';
import 'package:animo/models/content/video_subtitle.dart';
import 'package:animo/utils/crypto_aes.dart';

part 'rapidcloud.g.dart';

@riverpod
RapidCloud rapidCloud(RapidCloudRef ref) {
  return RapidCloud();
}

class RapidCloud implements VideoExtractor {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  Future<List<List<int>>> getIndexPairs() async {
    final res = await _dio.get<String>(
      'https://raw.githubusercontent.com/theonlymo/keys/e1/key',
    );

    return List.from(
      (jsonDecode(res.data!) as List).map((e) => List<int>.from(e)),
    );
  }

  @override
  Future<VideoData> extract(String url) async {
    final uri = Uri.parse(url);
    final id = url.split('/').last.split('?').first;
    final res = await _dio.get(
      'https://${uri.host}/embed-2/ajax/e-1/getSources?id=$id',
    );
    final resData = res.data!;
    final tracks = resData['tracks'] as List;
    final List<Map<String, dynamic>> sourcesRaw;

    if (resData!['encrypted']) {
      final ciphered = resData['sources'];
      final indexPairs = await getIndexPairs();
      String password = '';
      String ciphertext = ciphered;
      int index = 0;
      for (List<int> item in indexPairs) {
        int start = item.first + index;
        int end = start + item.last;
        String passSubstr = ciphered.substring(start, end);
        password += passSubstr;
        ciphertext = ciphertext.replaceFirst(passSubstr, '');
        index += item.last;
      }

      final decrypted = jsonDecode(
        CryptoAES.decryptAESCryptoJS(ciphertext, password),
      ) as List;

      sourcesRaw = decrypted.map((e) => e as Map<String, dynamic>).toList();
    } else {
      sourcesRaw = resData['sources'];
    }

    String masterUrl = sourcesRaw.first['file'];
    String type = sourcesRaw.first['type'];
    final List<VideoSource> sources = [];

    if (type == 'hls') {
      final playlistRes = await _dio.get<String>(masterUrl);
      final playlistData = playlistRes.data!;

      for (var entry in playlistData.split('#EXT-X-STREAM-INF:')..removeAt(0)) {
        final qualityStart = entry.indexOf('x') + 1;
        final quality = '${entry.substring(
          qualityStart,
          entry.indexOf(',', qualityStart),
        )}p';
        String videoUrl = entry.split('\n')[1];

        if (!videoUrl.startsWith('http')) {
          videoUrl =
              masterUrl.substring(0, masterUrl.lastIndexOf('/') - 1) + videoUrl;
        }

        sources.add(
          VideoSource(
            quality: quality,
            url: videoUrl,
            originalUrl: masterUrl,
          ),
        );
      }
    } else {
      sources.add(VideoSource(quality: 'Default', url: masterUrl));
    }

    final List<VideoSubtitle> subtitles = [];

    for (var track in tracks) {
      if (track['kind'] != 'captions') continue;

      subtitles.add(VideoSubtitle(label: track['label'], file: track['file']));
    }

    return VideoData(headers: {}, sources: sources, subtitles: subtitles);
  }
}
