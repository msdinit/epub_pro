class UrlUtils {
  /// Safely decodes a URI string, handling raw CJK characters and malformed percent-encoding.
  ///
  /// Some EPUBs incorrectly use raw CJK characters in hrefs.
  /// Standard [Uri.decodeFull] might throw [ArgumentError] if it encounters
  /// non-ASCII symbols.
  static String maybeDecode(String url) {
    try {
      return Uri.decodeFull(url);
    } catch (e) {
      // Support non-encoded href attributes as well
      // As an example - Kusamakura from
      // https://idpf.github.io/epub3-samples/30/samples.html
      if (!url.contains('%') && !url.contains('+')){
        // not encoded at all
        return url;
      }
      rethrow;
    }
  }
}
