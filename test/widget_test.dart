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
import 'package:flapp/src/models/subreddit.dart';
import 'package:flapp/src/main.dart';
import 'package:flappy_search_bar_ns/flappy_search_bar_ns.dart';
import 'package:flapp/src/views/image_header.dart';
import 'package:flapp/src/models/redditor.dart';

Future checkingDrawer(WidgetTester tester) async {
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
}

Future goingSearch(WidgetTester tester) async {
  // Build our app and trigger a frame.
  await tester.pumpWidget(Flapp(connected:  GetIt.I<RedditInterface>().connected));
  final burgerButton = find.byIcon(Icons.menu);
  expect(burgerButton, findsOneWidget);
  await tester.tap(burgerButton);
  await tester.pump();
  final drawerHeader = find.byType(DrawerHeader);
  expect(drawerHeader, findsOneWidget);
  final searchBtn = find.byIcon(Icons.manage_search);
  expect(searchBtn, findsOneWidget);
  await tester.pump(new Duration(milliseconds: 500));
  await tester.tap(searchBtn);
  await tester.pump(new Duration(milliseconds: 500));
  await tester.pump();
  //finds the searchbar
  final searchText = find.text("Search Subreddits");
  expect(searchText, findsOneWidget);
}

Future goingHome(WidgetTester tester) async {
  // Build our app and trigger a frame.
  await tester.pumpWidget(Flapp(connected:  GetIt.I<RedditInterface>().connected));
  final burgerButton = find.byIcon(Icons.menu);
  expect(burgerButton, findsOneWidget);
  await tester.tap(burgerButton);
  await tester.pump();
  final drawerHeader = find.byType(DrawerHeader);
  expect(drawerHeader, findsOneWidget);
  final homeBtn = find.byIcon(Icons.home);
  expect(homeBtn, findsOneWidget);
  await tester.pump(new Duration(milliseconds: 500));
  await tester.tap(homeBtn);
  await tester.pump(new Duration(milliseconds: 500));
  await tester.pump();
  //find the tab of a subreddit in the home pages
  final tabs = find.byType(Tab);
  expect(tabs, findsWidgets);
}

Future goingSettings(WidgetTester tester) async {
  // Build our app and trigger a frame.
  await tester.pumpWidget(Flapp(connected:  GetIt.I<RedditInterface>().connected));
  final burgerButton = find.byIcon(Icons.menu);
  expect(burgerButton, findsOneWidget);
  await tester.tap(burgerButton);
  await tester.pump();
  final drawerHeader = find.byType(DrawerHeader);
  expect(drawerHeader, findsOneWidget);
  final settingsBtn = find.byIcon(Icons.settings);
  expect(settingsBtn, findsOneWidget);
  await tester.pump(new Duration(milliseconds: 500));
  await tester.tap(settingsBtn);
  await tester.pump(new Duration(milliseconds: 500));
  await tester.pump();
  // find the switch toggles in the settings page
  final settingsSwitchs = find.byType(Switch);
  expect(settingsSwitchs, findsWidgets);
}

Future goingProfile(WidgetTester tester) async {
  await tester.pumpWidget(Flapp(connected:  GetIt.I<RedditInterface>().connected));
  final burgerButton = find.byIcon(Icons.menu);
  expect(burgerButton, findsOneWidget);
  await tester.tap(burgerButton);
  await tester.pump();
  final drawerHeader = find.byType(DrawerHeader);
  expect(drawerHeader, findsOneWidget);
  final profileBtn = find.byIcon(Icons.account_circle);
  expect(profileBtn, findsOneWidget);
  await tester.pump(new Duration(milliseconds: 500));
  await tester.tap(profileBtn);
  await tester.pump(new Duration(milliseconds: 500));
  await tester.pump();
  final imgHeader = find.byType(ImageHeader);
  //find the header with rrofile image and banner
  expect(imgHeader, findsOneWidget);
}

void main() async {
  setUp(() {
    WidgetsBinding.instance?.renderView.configuration = new TestViewConfiguration(size: const Size(1200, 1980));
  });
  TestWidgetsFlutterBinding.ensureInitialized();
  io.HttpOverrides.global = null;
  await dotenv.load(fileName: '.env');
  RedditInterface interface = RedditInterface();
  GetIt.I.registerSingleton<RedditInterface>(interface);
  await interface.restoreAPIConnectionTest();

  testWidgets('Checking drawer buttons', checkingDrawer);
  testWidgets('Going to profile page', goingProfile);
  testWidgets('Going to settings page', goingSettings);
  testWidgets('Going to search page', goingSearch);
  testWidgets('Going to home page', goingHome);
}
