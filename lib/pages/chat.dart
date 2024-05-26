import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bnb.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final name = FirebaseAuth.instance.currentUser?.displayName ?? 'User';

  final Gemini gemini = Gemini.instance;

  final ChatUser currentUser = ChatUser(id: '0', firstName: 'User');
  final ChatUser geminiUser = ChatUser(
      id: '1',
      firstName: 'Gemini',
      profileImage:
          'https://www.seeklogo.com/images/G/google-gemini-logo-A5787B2669-seeklogo.com.png');

  List<ChatMessage> messages = [
    ChatMessage(
        user: ChatUser(
            id: '1',
            firstName: 'Gemini',
            profileImage:
                'https://www.seeklogo.com/images/G/google-gemini-logo-A5787B2669-seeklogo.com.png'),
        createdAt: DateTime.now(),
        text:
            "Welcome to PneumoGuard! Your AI assistant, Gemini, is here to answer your questions.")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6E3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F6E3),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
          color: const Color(0xFF97E7E1),
        ),
        centerTitle: true,
        title: Text('Chat',
            style: GoogleFonts.raleway(
                color: const Color(0xFF7AA2E3),
                fontWeight: FontWeight.w700,
                fontSize: 24)),
        actions: const [],
      ),
      body: _buildUI(),
      bottomNavigationBar: const myBottomBar(),
    );
  }

  Widget _buildUI() {
    return DashChat(
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
      messageOptions: const MessageOptions(
        timeFontSize: 14,
        currentUserContainerColor: Color(0xFF7AA2E3),
      ),
      inputOptions: const InputOptions(
        sendOnEnter: true,
        inputTextStyle: TextStyle(fontSize: 16),
      ),
    );
  }

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });
    try {
      String question = chatMessage.text;
      gemini.streamGenerateContent(question).listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0);
          String response = event.content?.parts?.fold(
                  '', (previous, current) => "$previous${current.text}") ??
              '';
          lastMessage.text += response;
          setState(() {
            messages = [lastMessage!, ...messages];
          });
        } else {
          String response = event.content?.parts?.fold(
                  '', (previous, current) => "$previous ${current.text}") ??
              '';
          ChatMessage message = ChatMessage(
              user: geminiUser, createdAt: DateTime.now(), text: response);
          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
