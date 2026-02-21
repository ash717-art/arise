# Project Blueprint

## Overview
This document outlines the project structure, design, and features of the Flutter application.

## Changes Implemented
*   **Onboarding Flow & Data Reset:** Implemented a mechanism to check if the user has completed onboarding. New users will go through the onboarding process, and existing users will be taken directly to the main screen. The user's progress is now reset if onboarding is not complete, ensuring a fresh start for new users. This is handled by a flag and a reset function in `shared_preferences`.
*   **Data Persistence:** Ensured that user data is persisted locally on the device using `shared_preferences`.
*   **Continue Button Style:** The default `ElevatedButton` has been replaced with a custom "crystal glass" button. This provides a more modern and visually appealing call-to-action button across all screens. The new button uses a `GestureDetector` and `GlassContainer` to create the effect, with a blue accent color. The color has been updated to a crystal dark translucent blue.
*   **Pixel Overflow Fixes:**
    *   **Summary Screen:** A pixel overflow issue on the summary screen has been resolved. The `Row` containing `StatPill` widgets was causing the overflow when the text values were too long. The fix involves wrapping each `StatPill` with an `Expanded` widget, allowing the text to wrap and preventing the layout from overflowing.
    *   **Quest Info Modal:** A pixel overflow issue in the `QuestInfoModal` (shown after clicking "Start Workout") has been fixed by wrapping the `quest.summary`, exercise name, and exercise description `Text` widgets in `Row` and `Expanded` to allow them to wrap.
    *   **Dashboard Screen:** A pixel overflow issue on the dashboard screen has been resolved. The `_StreakTrackerCard` widget was causing the overflow when the streak numbers were too large. The fix involves wrapping the `Column`s displaying the streak numbers in `Expanded` widgets and the `Text` widgets with the large numbers in `FittedBox` to prevent pixel overflow.
*   **Projection Chart Fixed:** The 90-day projection chart has been fixed and updated.
    *   The Y-axis labels have been updated to 'E', 'D', 'C', 'B', 'A', 'S' from bottom to top.
    *   The X-axis labels ('Start', 'Month 1', 'Month 2', 'Month 3') are now correctly aligned with the data points on the graph.
    *   The graph's data has been adjusted to show a reasonable progression through the new ranks, with small deviations to make it look more realistic.
    *   Vertical dashed lines have been added to indicate each month.
*   **Fingerprint Lock-in Screen Navigation Fixed:** A bug was fixed where the app would get stuck after the fingerprint lock-in screen. The navigation logic was moved from the `onLockedIn` callback in `projection_screen.dart` to inside the `fingerprint_lockin_screen.dart` itself. This ensures that a valid `BuildContext` is used for navigation, resolving the issue.
*   **Screen Content Population:**
    *   **Progress Screen:** The previously blank `ProgressScreen` now displays user progress, including rank, level, XP, and quests completed, using `MetricCard` and `StatPill` widgets.
    *   **Nutrition Screen:** The previously blank `NutritionScreen` now displays the user's nutritional goals, including calorie, macro, and water intake goals, calculated based on their onboarding data.
*   **Code Quality:** Ran `dart analyze` and fixed all reported issues.

## Current State
The application is now much more robust and feature-complete. The onboarding flow is correctly handled, data is persisted locally and reset for new users, and several UI bugs have been fixed. The progress and nutrition screens are now functional, providing value to the user. The codebase has been analyzed and cleaned up.
