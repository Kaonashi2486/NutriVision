// lib/locator.dart
import 'package:fitnessapp/utils/chat_service.dart';
import 'package:fitnessapp/view_models/user_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:fitnessapp/view_models/user_view_model.dart';

// Initialize GetIt
final GetIt getIt = GetIt.instance;

void setupLocator() {
  // Registering UserViewModel as a singleton
  getIt.registerSingleton<UserViewModel>(UserViewModel(
    name: 'John Doe', // Initial values, could be dynamic
    height: 175.0,
    weight: 40.0,
    age: 25,
    pastDiseases: ['Flu', 'Chickenpox'],
  ));
  getIt.registerLazySingleton<ChatViewModel>(() => ChatViewModel());
  // Hardcoding previous chats after registration
  var chatViewModel = getIt<ChatViewModel>();
  // Adding some hardcoded previous chats
  chatViewModel
      .addPreviousChat(["You: Hello", "Bot: Hi there! How can I help you?"]);
}
