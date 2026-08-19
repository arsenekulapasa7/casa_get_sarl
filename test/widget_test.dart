import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:casaget_website/main.dart';

void main() {
  testWidgets('switching language updates the visible labels', (tester) async {
    final view = tester.view;
    view.physicalSize = const Size(1440, 1200);
    view.devicePixelRatio = 1.0;
    addTearDown(() {
      view.resetPhysicalSize();
      view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const MyApp());

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Contact'), findsOneWidget);
    expect(find.text('Leisure'), findsOneWidget);
    expect(find.text('Blog'), findsOneWidget);

    await tester.ensureVisible(find.text('FR'));
    await tester.tap(find.text('FR'));
    await tester.pumpAndSettle();

    expect(find.text('Accueil'), findsOneWidget);
    expect(find.text('Contact'), findsOneWidget);
    expect(find.text('Loisirs'), findsOneWidget);
    expect(find.text('Blog'), findsOneWidget);
  });

  testWidgets('tapping leisure and blog opens dedicated pages', (tester) async {
    final view = tester.view;
    view.physicalSize = const Size(1440, 1200);
    view.devicePixelRatio = 1.0;
    addTearDown(() {
      view.resetPhysicalSize();
      view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Leisure'));
    await tester.pumpAndSettle();
    expect(find.text('Leisure'), findsWidgets);

    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Blog'));
    await tester.pumpAndSettle();
    expect(find.text('Blog'), findsWidgets);
  });
}
