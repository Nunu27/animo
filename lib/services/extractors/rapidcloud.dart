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

  final serverUrl = ['https://megacloud.tv', 'https://rapid-cloud.co'];

  final jsPlayerUrl = [
    'https://megacloud.tv/js/player/a/prod/e1-player.min.js',
    'https://rapid-cloud.co/js/player/prod/e6-player-v2.min.js'
  ];
  final sourceUrl = [
    '/embed-2/ajax/e-1/getSources?id=',
    '/ajax/embed-6-v2/getSources?id='
  ];

  List<List<int>> chunked(List<int> list, int size) {
    List<List<int>> chunks = [];
    for (int i = 0; i < list.length; i += size) {
      int end = list.length;
      if (i + size < list.length) {
        end = i + size;
      }
      chunks.add(list.sublist(i, end));
    }
    return chunks;
  }

  Future<List<List<int>>> generateIndexPairs(int serverType) async {
    final scriptText = (await _dio.get<String>(jsPlayerUrl[serverType])).data;

    if (scriptText == null) throw 'Failed';

    final switchCode = scriptText.substring(
        scriptText.lastIndexOf('switch'), scriptText.indexOf('=partKey'));

    List<int> indexes = [];
    for (var variableMatch
        in RegExp(r'=(\w+)').allMatches(switchCode).toList()) {
      final regex =
          RegExp(',${(variableMatch).group(1)}=((?:0x)?([0-9a-fA-F]+))');
      Match? match = regex.firstMatch(scriptText);

      if (match != null) {
        String value = match.group(1)!;
        if (value.contains('0x')) {
          indexes.add(
              int.parse(value.substring(value.indexOf('0x') + 2), radix: 16));
        } else {
          indexes.add(int.parse(value));
        }
      }
    }

    return chunked(indexes, 2);
  }

  @override
  Future<VideoData> extract(String url) async {
    final serverType = url.startsWith('https://megacloud.tv') ? 0 : 1;
    final id = url.split('/').last.split('?').first;

    final res = await _dio.get(
      serverUrl[serverType] + sourceUrl[serverType] + id,
    );
    final resData = res.data!;
    final tracks = resData['tracks'] as List;
    final List<Map<String, dynamic>> sourcesRaw;

    if (resData!['encrypted']) {
      final String ciphered = resData['sources'];
      final indexPairs = await generateIndexPairs(serverType);
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
