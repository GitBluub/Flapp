// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:io' as io;
import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flapp/src/models/reddit_interface.dart';
import 'package:flapp/src/main.dart';
import 'package:flapp/src/models/redditor.dart';

void main() async {

  TestWidgetsFlutterBinding.ensureInitialized();
  io.HttpOverrides.global = null;
  await dotenv.load(fileName: '.env');
  RedditInterface interface = RedditInterface();
  GetIt.I.registerSingleton<RedditInterface>(interface);
  await interface.restoreAPIConnectionTest();
  testWidgets('Going to profile page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(Flapp(connected:  GetIt.I<RedditInterface>().connected));
    final burgerButton = find.byIcon(Icons.menu);
    expect(burgerButton, findsOneWidget);
    await tester.tap(burgerButton);
    await tester.pump();
    final drawerHeader = find.byType(DrawerHeader);
    expect(drawerHeader, findsOneWidget);
    final searchBtn = find.byIcon(Icons.manage_search);
    final settingsBtn = find.byIcon(Icons.settings);
    final homeBtn = find.byIcon(Icons.home);
    final profileBtn = find.byIcon(Icons.account_circle);
    expect(searchBtn, findsOneWidget);
    expect(settingsBtn, findsOneWidget);
    expect(homeBtn, findsOneWidget);
    expect(profileBtn, findsOneWidget);
  });
}
