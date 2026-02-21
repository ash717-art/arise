import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/onboarding_model.dart';

class OnboardingNotifier extends StateNotifier<OnboardingModel> {
  OnboardingNotifier() : super(OnboardingModel());

  void setGender(Gender gender) {
    state = state.copyWith(gender: gender);
  }

  void setGoal(Goal goal) {
    state = state.copyWith(goal: goal);
  }

  void toggleMotivation(Motivation motivation) {
    final newMotivations = List<Motivation>.from(state.motivations);
    if (newMotivations.contains(motivation)) {
      newMotivations.remove(motivation);
    } else {
      newMotivations.add(motivation);
    }
    state = state.copyWith(motivations: newMotivations);
  }

  void toggleFocusArea(FocusArea focusArea) {
    final newFocusAreas = List<FocusArea>.from(state.focusAreas);
    if (newFocusAreas.contains(focusArea)) {
      newFocusAreas.remove(focusArea);
    } else {
      newFocusAreas.add(focusArea);
    }
    state = state.copyWith(focusAreas: newFocusAreas);
  }

  void setFitnessLevel(FitnessLevel fitnessLevel) {
    state = state.copyWith(fitnessLevel: fitnessLevel);
  }

  void setActivityLevel(ActivityLevel activityLevel) {
    state = state.copyWith(activityLevel: activityLevel);
  }

  void setCurrentWeight(double weight) {
    state = state.copyWith(currentWeight: weight);
  }

  void setWeightUnit(String unit) {
    state = state.copyWith(weightUnit: unit);
  }

  void setTargetWeight(double weight) {
    state = state.copyWith(targetWeight: weight);
  }

  void setHeight(double height) {
    state = state.copyWith(height: height);
  }

  void setHeightUnit(String unit) {
    state = state.copyWith(heightUnit: unit);
  }

  void setHealthIssue(HealthIssue healthIssue) {
    state = state.copyWith(healthIssue: healthIssue);
  }

  void toggleEquipment(Equipment equipmentItem) {
    final newEquipment = List<Equipment>.from(state.equipment);
    if (newEquipment.contains(equipmentItem)) {
      newEquipment.remove(equipmentItem);
    } else {
      newEquipment.add(equipmentItem);
    }
    state = state.copyWith(equipment: newEquipment);
  }

  void setWorkoutsPerWeek(int count) {
    state = state.copyWith(workoutsPerWeek: count);
  }

  void toggleWorkoutDay(String day) {
    final newWorkoutDays = List<String>.from(state.workoutDays);
    if (newWorkoutDays.contains(day)) {
      newWorkoutDays.remove(day);
    } else {
      if (newWorkoutDays.length < state.workoutsPerWeek) {
        newWorkoutDays.add(day);
      }
    }
    state = state.copyWith(workoutDays: newWorkoutDays);
  }

  void setReminders(bool enabled) {
    state = state.copyWith(remindersEnabled: enabled);
  }
}

final onboardingProvider =
    StateNotifierProvider<OnboardingNotifier, OnboardingModel>((ref) {
      return OnboardingNotifier();
    });
