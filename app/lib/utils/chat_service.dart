// lib/viewmodels/chat_view_model.dart

import 'package:get_it/get_it.dart';

class ChatViewModel {
  List<String> _messages = [];
  List<String> _title = [];
  List<List<String>> _previousChats = [];

  // Getter for the messages
  List<String> get messages => _messages;
  List<String> get title => _title;
  // Getter for previous chats
  List<List<String>> get previousChats => _previousChats;

  // Method to add a new message
  void addMessage(String message) {
    _messages.add(message);
  }

  // Method to add a previous chat
  void addPreviousChat(List<String> chat) {
    if (chat.isEmpty) {
      return; // Don't add empty chats
    }

    var len = 0;
    var ti = (chat[0].isEmpty) ? "null" : chat[0];

    // Ensure the title string is not too short to prevent index errors
    len = ti.length > 10 ? 10 : ti.length;

    // If title length is greater than 1, we can safely use substring
    if (ti.length > 1) {
      _title.add(ti.substring(4, len));
    } else {
      _title.add(ti);
    }

    _previousChats.add(chat);
  }

  // Method to load a previous chat
  List<String> loadPreviousChat(int index) {
    _messages = List.from(_previousChats[index]);
    return List.from(_previousChats[index]);
  }

  // Method to add a file attachment message
  void addFileMessage(String fileName, String filePath) {
    String fileMessage = "You: [File: $fileName](file://$filePath)";
    _messages.add(fileMessage);
  }

  // Simulated response from the chatbot
  String getBotResponse(String userMessage) {
    // For simplicity, we echo back the user's message
    return "Bot: You said '$userMessage'. How can I assist you further?";
  }

  // Method to update the chat state (optional)
  void updateChatState({List<String>? newMessages}) {
    if (newMessages != null) {
      _messages = newMessages;
    }
  }
}

// Register the ChatViewModel with GetIt
final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton(() => ChatViewModel());
}
