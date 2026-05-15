// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  late FlutterDriver driver;

  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  // Close the connection to the driver after the tests have completed.
  /* tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  }); */

  ///////
  /*
  Here we will assign all of the keys that are on the codebase to variables 
  to make it simpler
  */
  ///////

  // Home screen buttons
  // Note: Place all keys inside Text() for the finder to work
  final infoScreenCarpInfoFinder = find.text(
      "The common carp is one of the largest members of the minnow family and a close relative of the goldfish. The carp’s closest look-alikes may be the bigmouth and smallmouth buffalos, which despite their resemblance to the carp, belong to an entirely different family (the sucker family).");
  final infoScreenBackButton = find.byValueKey("info-screen-back-button");
  final homeScreenTitleFinder = find.text("What reels you in today?");
  final searchScreenTitleFinder = find.text("List of Species");
  final searchScreenFishButtonFinder = find.text("Bass");
  final searchScreenCarpFishButtonFinder = find.text("Carp");
  final searchScreenEelFishButtonFinder = find.text("Eel");
  final searchScreenSearchBarFinder =
      find.byValueKey("search-screen-search-bar");
  final searchScreenBackButton = find.byValueKey("search-screen-back-button");
  final infoScreenTitleFinder = find.byValueKey("info-screen-title");
  final scanButtonTextFinder = find.byValueKey("scan-button");
  final searchButtonTextFinder = find.byValueKey("search-button");
  final logButtonTextFinder = find.byValueKey("log-button");
  final logScreenBackButtonFinder =
      find.byValueKey("new-catch-log-back-button");
  final logBassTextFinder = find.text('bass');
  final logPufferfishTextFinder = find.text('pufferfish');
  final logScreenTitleFinder = find.byValueKey("new-catch-log-title");
  final scanScreenTitleTextFinder = find.byValueKey("scan-title");
  final scanScreenResultTextFinder = find.byValueKey("scan-result-text");
  final scanBackButtonFinder = find.byValueKey('scan-back-button');
  final scanOptionsButtonFinder = find.byValueKey("options-button");
  final scanLogFishOptionButtonFinder =
      find.byValueKey("log-fish-option-button");
  final scanFishInfoOptionButtonFinder =
      find.byValueKey("fish-info-option-button");
  final scanCameraButtonFinder = find.byValueKey("camera-button");
  final scanGalleryButtonFinder = find.byValueKey("gallery-button");

  group("Happy Paths:", () {
    test("Check the home screen is displayed", () async {
      expect(await driver.getText(homeScreenTitleFinder),
          "What reels you in today?");
    });
    test("Check all buttons are available in homescreen", () async {
      expect(
          await driver.getText(scanButtonTextFinder), "        Scan          ");
      expect(await driver.getText(searchButtonTextFinder),
          "             Search       ");
      expect(await driver.getText(logButtonTextFinder),
          "             Log          ");
    });
  });

  group("Search screen tests:", () {
    test("Click on search screen button and find list of fishes", () async {
      await driver.tap(searchButtonTextFinder);
      expect(await driver.getText(searchScreenTitleFinder), "List of Species");
    });

    test("Click on Bass button and navigate to info screen", () async {
      await driver.tap(searchScreenFishButtonFinder);
      expect(await driver.getText(infoScreenTitleFinder), "Bass");
    });
    test(
        "Click back arrow button in info screen and navigate back to search screen",
        () async {
      await driver.tap(infoScreenBackButton);
      expect(await driver.getText(searchScreenTitleFinder), "List of Species");
    });

    test("Scroll down on search screen until tilapia button is found",
        () async {
      await driver.scrollUntilVisible(
          find.byValueKey("search-screen-list"), find.text('Tilapia'),
          dyScroll: -100);
    });

    test(
        "Tap on search bar and enter carp and carp button should appear in the search results",
        () async {
      await driver.tap(searchScreenSearchBarFinder);
      await driver.enterText('carp');
      await driver.waitFor(find.text('carp'));
      expect(await driver.getText(searchScreenCarpFishButtonFinder), "Carp");
    });

    test("Tap Carp button and find Carp info screen", () async {
      await driver.tap(searchScreenCarpFishButtonFinder);
      expect(await driver.getText(infoScreenCarpInfoFinder),
          "The common carp is one of the largest members of the minnow family and a close relative of the goldfish. The carp’s closest look-alikes may be the bigmouth and smallmouth buffalos, which despite their resemblance to the carp, belong to an entirely different family (the sucker family).");
    });

    test("Tap back button on Carp info screen, and find Search Screen",
        () async {
      await driver.tap(infoScreenBackButton);
      expect(await driver.getText(searchScreenTitleFinder), "List of Species");
    });
    test(
        "Tap search bar, enter Eel, tap Eel on search results, find Eel info Screen. After getting to the info screen go back to home screen",
        () async {
      await driver.tap(searchScreenSearchBarFinder);
      await driver.enterText('eel');
      await driver.waitFor(find.text('eel'));
      expect(await driver.getText(searchScreenEelFishButtonFinder), "Eel");

      await driver.tap(searchScreenEelFishButtonFinder);
      expect(await driver.getText(infoScreenTitleFinder), "Eel");
    });

    test(
        "After getting to the Eel info screen go back to Home Screen by tapping back buttons",
        () async {
      await driver.tap(infoScreenBackButton);
      expect(await driver.getText(searchScreenTitleFinder), "List of Species");
      await driver.tap(searchScreenBackButton);
      expect(await driver.getText(homeScreenTitleFinder),
          "What reels you in today?");
    });
  });

  group("Scan Screen tests:", () {
    test("After tapping scan button, navigate to the scan screen", () async {
      await driver.tap(scanButtonTextFinder);
      expect(await driver.getText(scanScreenTitleTextFinder), 'Scan');
    });

    test(
        "After tapping the camera button, predict bass fish and navigate to different screens",
        () async {
      // tapping the camera button will load bass image
      driver.tap(scanCameraButtonFinder);
      await Future.delayed(Duration(seconds: 3));
      expect(await driver.getText(scanScreenResultTextFinder), "It's a bass!");

      // Navigate to info screen and expect bass info
      driver.tap(scanOptionsButtonFinder);
      driver.tap(scanFishInfoOptionButtonFinder);

      expect(await driver.getText(infoScreenTitleFinder), 'Bass');

      // Go back to scan screen
      driver.tap(infoScreenBackButton);
      expect(await driver.getText(scanScreenTitleTextFinder), 'Scan');

      // Navigate to log screen and expect species form filled
      driver.tap(scanOptionsButtonFinder);
      driver.tap(scanLogFishOptionButtonFinder);

      expect(await driver.getText(logScreenTitleFinder), 'New Catch Log');
      expect(await driver.getText(logBassTextFinder), 'bass');

      // Navigate back to scan screen
      driver.tap(logScreenBackButtonFinder);
      expect(await driver.getText(scanScreenTitleTextFinder), 'Scan');
    });

    test(
        "After tapping the gallery button, predict pufferfish and navigate to different screens",
        () async {
      // tapping the gallery button will load crappy image
      driver.tap(scanGalleryButtonFinder);
      await Future.delayed(Duration(seconds: 3));
      expect(await driver.getText(scanScreenResultTextFinder),
          "It's a pufferfish!");

      // Navigate to info screen and expect bass info
      driver.tap(scanOptionsButtonFinder);
      driver.tap(scanFishInfoOptionButtonFinder);

      expect(await driver.getText(infoScreenTitleFinder), 'Pufferfish');

      // Go back to scan screen
      driver.tap(infoScreenBackButton);
      expect(await driver.getText(scanScreenTitleTextFinder), 'Scan');

      // Navigate to log screen and expect species form filled
      driver.tap(scanOptionsButtonFinder);
      driver.tap(scanLogFishOptionButtonFinder);

      expect(await driver.getText(logScreenTitleFinder), 'New Catch Log');
      expect(await driver.getText(logPufferfishTextFinder), 'pufferfish');

      // Navigate back to scan screen
      driver.tap(logScreenBackButtonFinder);
      expect(await driver.getText(scanScreenTitleTextFinder), 'Scan');

      // Navigate back to main menu
      driver.tap(scanBackButtonFinder);
      expect(await driver.getText(homeScreenTitleFinder),
          'What reels you in today?');
    });
  });
}

// add the rest of the tests for the rest of the screens
