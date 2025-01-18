// lib/screens/chat_screen.dart

import 'package:fitnessapp/utils/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class ChatScreen extends StatefulWidget {
  static String routeName = "/Chat";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<String>? Messages;
  final TextEditingController _controller = TextEditingController();
  final ChatViewModel _chatViewModel = GetIt.I<ChatViewModel>();
  bool hasChanges = false; // Track if the current chat has changes

  @override
  void initState() {
    super.initState();
    _chatViewModel.addPreviousChat([]);
  }

  // Method to pick a file using FilePicker
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      String fileName = result.files.single.name;
      String filePath = result.files.single.path ?? "";

      // Add the file name as a clickable link to the chat
      _chatViewModel.addMessage("You: [File: $fileName](file://$filePath)");

      setState(() {
        hasChanges = true; // Mark as changed when a file is picked
      });
    }
  }

  // Method to launch the file when clicked
  Future<void> _launchFile(String filePath) async {
    if (await canLaunch(filePath)) {
      await launch(filePath);
    } else {
      throw 'Could not open the file';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot'),
        actions: [
          IconButton(
            icon: Icon(Icons.attach_file, size: screenWidth * 0.07),
            onPressed: () {
              setState(() {
                if (hasChanges) {
                  _chatViewModel.addPreviousChat(Messages!);
                  _chatViewModel.updateChatState(newMessages: []);
                  hasChanges = false;
                } else {
                  _chatViewModel.updateChatState(newMessages: []);
                  Messages?.clear();
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.keyboard_return, size: screenWidth * 0.07),
            onPressed: () {
              setState(() {
                if (hasChanges) {
                  _chatViewModel.addPreviousChat(Messages!);
                  _chatViewModel.updateChatState(newMessages: []);
                  hasChanges = false;
                  Navigator.pop(context);
                } else {
                  _chatViewModel.updateChatState(newMessages: []);
                  Messages?.clear();
                  Navigator.pop(context);
                }
              });
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView.builder(
          itemCount: _chatViewModel.previousChats.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_chatViewModel.title[index],
                  style: TextStyle(fontSize: screenWidth * 0.04)),
              onTap: () {
                if (hasChanges) {
                  _chatViewModel
                      .addPreviousChat(List.from(_chatViewModel.messages));
                  Messages?.clear();
                  hasChanges = false;
                }

                Messages = _chatViewModel.loadPreviousChat(index);

                Navigator.pop(context);
                setState(() {});
              },
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _chatViewModel.messages.length,
              itemBuilder: (context, index) {
                String message = _chatViewModel.messages[index];

                if (message.contains("[File:") && message.contains("]")) {
                  String fileName = message.substring(
                      message.indexOf("[File:") + 7, message.indexOf("]"));
                  return ListTile(
                    title: GestureDetector(
                      onTap: () => _launchFile(message.split("(file://")[1]),
                      child: Text(
                        fileName,
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.04),
                      ),
                    ),
                  );
                } else {
                  return ListTile(
                    title: Text(message,
                        style: TextStyle(fontSize: screenWidth * 0.04)),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                    ),
                    style: TextStyle(fontSize: screenWidth * 0.04),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.save_alt, size: screenWidth * 0.07),
                  onPressed: () {
                    setState(() {
                      if (hasChanges == true) {
                        _chatViewModel.addPreviousChat(Messages!);
                        _chatViewModel.updateChatState(newMessages: Messages);
                        hasChanges = false;
                        Messages?.clear();
                      }
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.attach_file, size: screenWidth * 0.07),
                  onPressed: _pickFile,
                ),
                IconButton(
                  icon: Icon(Icons.send, size: screenWidth * 0.07),
                  onPressed: () {
                    String userMessage = _controller.text;
                    if (userMessage.isNotEmpty) {
                      _chatViewModel.addMessage("You: $userMessage");
                      Messages?.add(userMessage);

                      String botResponse =
                          _chatViewModel.getBotResponse(userMessage);
                      _chatViewModel.addMessage(botResponse);
                      Messages?.add(botResponse);

                      _controller.clear();
                      setState(() {
                        hasChanges = true;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
