import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/project_models.dart';

class NewsRepository {
  NewsRepository._();

  static const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
  static const imageBucket = 'news-images';

  static bool get isConfigured =>
      supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;

  static Future<void> initialize() async {
    if (!isConfigured) return;
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  }

  static SupabaseClient get _client => Supabase.instance.client;

  static Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await _client.auth.signInWithPassword(email: email, password: password);
  }

  static Future<void> signOut() async {
    await _client.auth.signOut();
  }

  static Future<List<BlogPost>> fetchPublished(String language) async {
    if (!isConfigured) return const [];

    final isFrench = language == 'FR';
    final rows = await _client
        .from('news_articles')
        .select()
        .eq('published', true)
        .order('created_at', ascending: false)
        .limit(10);

    return rows
        .map((row) {
          final content =
              (row[isFrench ? 'content_fr' : 'content_en'] as String?) ?? '';
          final createdAt = DateTime.parse(
            row['created_at'] as String,
          ).toLocal();
          final words = content.trim().isEmpty
              ? 1
              : content.trim().split(RegExp(r'\s+')).length;
          final readMinutes = (words / 200).ceil().clamp(1, 99);

          return BlogPost(
            title: (row[isFrench ? 'title_fr' : 'title_en'] as String?) ?? '',
            excerpt:
                (row[isFrench ? 'excerpt_fr' : 'excerpt_en'] as String?) ?? '',
            content: content,
            category:
                (row[isFrench ? 'category_fr' : 'category_en'] as String?) ??
                (isFrench ? 'Actualité' : 'News'),
            date:
                '${createdAt.day.toString().padLeft(2, '0')}/'
                '${createdAt.month.toString().padLeft(2, '0')}/${createdAt.year}',
            readTime: '$readMinutes min',
            imagePath: (row['image_url'] as String?) ?? '',
          );
        })
        .where((post) => post.title.isNotEmpty && post.excerpt.isNotEmpty)
        .toList();
  }

  static Future<String> uploadImage(
    Uint8List bytes, {
    required String fileName,
    required String contentType,
  }) async {
    return uploadMedia(
      bytes,
      fileName: fileName,
      contentType: contentType,
    );
  }

  static Future<String> uploadMedia(
    Uint8List bytes, {
    required String fileName,
    required String contentType,
  }) async {
    final extension = fileName.contains('.') ? fileName.split('.').last : 'jpg';
    final path = '${DateTime.now().microsecondsSinceEpoch}.$extension';
    await _client.storage
        .from(imageBucket)
        .uploadBinary(
          path,
          bytes,
          fileOptions: FileOptions(contentType: contentType),
        );
    return _client.storage.from(imageBucket).getPublicUrl(path);
  }

  static Future<Map<String, String>> fetchSiteContent() async {
    if (!isConfigured) return const {};

    final rows = await _client.from('site_content').select('content_key, value');
    return {
      for (final row in rows)
        row['content_key'] as String: row['value'] as String,
    };
  }

  static Future<void> saveSiteContent(Map<String, String> values) async {
    if (!isConfigured || values.isEmpty) return;

    await _client.from('site_content').upsert(
      values.entries
          .map(
            (entry) => {
              'content_key': entry.key,
              'value': entry.value,
            },
          )
          .toList(),
      onConflict: 'content_key',
    );
  }

  static Future<void> publish({
    required String titleFr,
    required String excerptFr,
    required String contentFr,
    required String titleEn,
    required String excerptEn,
    required String contentEn,
    required String imageUrl,
  }) async {
    await _client.from('news_articles').insert({
      'title_fr': titleFr,
      'excerpt_fr': excerptFr,
      'content_fr': contentFr,
      'title_en': titleEn,
      'excerpt_en': excerptEn,
      'content_en': contentEn,
      'image_url': imageUrl,
      'published': true,
    });
  }
}
