import 'package:epub_pro/src/utils/url_utils.dart';
import 'package:test/test.dart';

void main() {
  group('UrlUtils.maybeDecode tests', () {
    test('safeDecode handles normal encoded characters', () {
      expect(UrlUtils.maybeDecode('hello%20world.xhtml'), 'hello world.xhtml');
    });

    test('maybeDecode handles raw CJK characters', () {
      const rawCjk = '测试.xhtml';
      expect(UrlUtils.maybeDecode(rawCjk), rawCjk);
    });

    test('mixed encoded and raw CJK is still invalid', () {
      const mixed = 'hello%20测试.xhtml';
      expect(() => UrlUtils.maybeDecode(mixed), throwsArgumentError);
    });
    
    test('invalid percent encoding throws', () {
      const invalid = 'hello%2world.xhtml';
      expect(() => UrlUtils.maybeDecode(invalid), throwsArgumentError);
    });

    test('maybeDecode throws for naked percentage sign', () {
      expect(() => UrlUtils.maybeDecode('discount%2050%.xhtml'), throwsArgumentError);
    });
  });
}
