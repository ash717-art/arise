# Arise Fitness App Blueprint

## Overview

Arise is a futuristic fitness application designed to provide users with a dynamic and personalized workout experience. It generates daily quests, adapts to the user's fitness level and goals, and provides a clear projection of their potential.

## Style and Design

- **Theme**: Dark futuristic theme.
- **Background**: Gradient from #070B12 to #071B2A.
- **Cards**: Background #0B2236, Border #14324A, Radius 16-20px.
- **Accent Colors**:
  - Primary: #2D8CFF (Blue)
  - Success: #47B85A (Green)
  - Neon Highlight: #66FF88 (Green)
  - Danger: #D83A3A (Red)
  - Muted Line: #8A97A6
- **Typography**: Bold white titles, muted blue-grey secondary text.

## Features Implemented

### Onboarding
- A comprehensive onboarding process to collect user data, including:
  - Gender, weight, height, age
  - Fitness level, activity level
  - Goals, focus areas, motivations
  - Health issues, equipment availability

### Summary Screen
- A detailed summary screen that provides a preview of the user's custom plan, including:
  - Weight trend projection.
  - BMI calculation and scale.
  - Calorie and macro goals.
  - Water intake goal.
  - Workout duration and rest time.

### Analysis & Stats Screens
- **Syncing Data Screen**: A loading screen to simulate data processing.
- **Analysis Complete Screen**: Compares the user's potential with an average baseline.
- **Current & Potential Stats Screens**: Shows the user's baseline stats (Strength, Vitality, Agility, Recovery) and their 90-day potential.

### Program & Projection
- **90-Day Projection Screen**: A visual representation of the user's projected progress over 90 days.
- **Program Intro Screen**: An introduction to the 90-day program.
- **Program Home Screen**: The main screen that displays the daily quest.

### Dynamic Quest Generation System
- A sophisticated system that generates daily workouts (quests) based on user data.
- **Exercise Pool**: A comprehensive list of exercises with details on type, difficulty, and equipment.
- **Quest Service**: The core of the dynamic system, with logic for:
  - **Daily Variation**: Ensures workouts are not repetitive.
  - **Progressive Difficulty**: Adjusts reps and sets based on the user's fitness level.
  - **Smart Weekly Split**: Switches between full-body workouts and push/pull/legs splits based on workout frequency.
  - **Injury Awareness**: Avoids exercises that may conflict with the user's health issues.
  - **Equipment Awareness**: Generates workouts based on the user's available equipment.
- **Quest Info Modal**: A modal that displays the details of the daily quest, including exercises, reps, sets, and XP reward.

## Current Plan

The current implementation focuses on completing the screen flow and the dynamic quest generation system.

### Steps for Current Request

1.  **Analyze and Fix Errors**: Run `flutter analyze` to ensure a clean codebase.
2.  **Implement Screen Flow**:
    - `SyncingDataScreen`: Implemented with animation and navigation.
    - `AnalysisCompleteScreen`: Implemented with dynamic potential calculation and bar chart.
    - `CurrentStatsScreen`: Implemented with dynamic stat calculation from onboarding data.
    - `PotentialStatsScreen`: Implemented with projected stats calculation.
    - `ProjectionScreen`: Implemented with a custom line chart showing 90-day projection.
    - `ProgramIntroScreen`: Implemented with dynamic end date and checklist.
    - `Final Sync Modal`: Implemented as a reusable modal.
3.  **Implement Dynamic Quest/Exercise Generation**:
    - `Exercise Model`: Defined the data structure for exercises.
    - `Exercise Service`: Created a service to provide a pool of exercises.
    - `Quest Model`: Defined the data structure for quests.
    - `Quest Service`: Implemented the core logic for dynamic quest generation, including:
        - Daily rotation with seeding.
        - Difficulty adaptation based on fitness level.
        - Smart weekly splits (PPL vs. Full Body).
        - Injury and equipment awareness.
        - XP reward calculation.
    - `ProgramHomeScreen`: Implemented to display the daily quest.
    - `QuestInfoModal`: Implemented to show quest details.
4.  **Finalize and Document**:
    - Update `blueprint.md` to reflect all the changes.
    - Run `flutter analyze` one last time.
    - Notify the user of completion.