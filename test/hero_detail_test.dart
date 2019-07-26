@TestOn('browser')

import 'package:angular_test/angular_test.dart';
import 'package:pageloader/html.dart';
import 'package:test/test.dart';
import '../lib/src/hero.dart';
import '../lib/src/hero_component.dart';
import '../lib/src/hero_component.template.dart' as ng;
import 'hero_detail_po.dart';

const targetHero = {'id': 1, 'name': 'Alice'};

NgTestFixture<HeroComponent> fixture;

HeroDetailPO po;

void main() {
  final testBed =
      NgTestBed.forComponent<HeroComponent>(ng.HeroComponentNgFactory);

  tearDown(disposeAnyRunningTest);

  group('No inital @Input Hero:', () {
    setUp(() async {
      fixture = await testBed.create();
      final context =
          HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      po = HeroDetailPO.create(context);
    });

    test('has an empty view', () {
      expect(fixture.rootElement.text.trim(), '');
      expect(po.heroFromDetail, isNull);
    });

    test('transition to ${targetHero['name]} hero', () async {
      await fixture.update((comp) {
        comp.hero = Hero(targetHero['id'], targetHero['name']);
      });
      expect(po.heroFromDetail, targetHero);
    });
  });
}
