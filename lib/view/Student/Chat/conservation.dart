import 'dart:io';
import 'package:course_selling/Configs.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:course_selling/Loding.dart';
import 'package:course_selling/_helpers/global.dart';
import 'package:dio/dio.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart' as emoji;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

// ignore: must_be_immutable
class ChattingScreen1 extends StatefulWidget {
  bool? isChatRoom = false;
  final int chatroomid;
  final int receverid;

  ChattingScreen1({
    super.key,
    required this.chatroomid,
    required this.receverid,
  });

  @override
  State<ChattingScreen1> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen1> {
  bool imageSelected = false;
  File img = File('');
  IO.Socket? socket;
  var dio = Dio();

  var textController = TextEditingController();
  List messages = [];
  bool _isEmojiPickerVisible = false;

  connectSocket() {
    socket = IO.io(Config.baseUrl2, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket?.connect();
    socket?.on('_receiveChat', (data) {
      receiveMessage(data);
    });
  }

  sendMessage(String text) async {
    textController.clear();
    if (text.isEmpty) {
      return;
    }
    int chatRoomId = widget.chatroomid;
    int receiverId = widget.receverid;
    socket!.emit('sendChat', {
      'text': text,
      'senderId': userSD['id'],
      'receiverId': receiverId,
      'chatRoomId': chatRoomId
    });

    var requestBody = {
      'senderId': userSD['id'],
      'receiverId': receiverId,
      'message': text,
      'chatRoomId': chatRoomId
    };
    await dio.post('${Config.baseUrl}/conversation', data: requestBody);

    // await appServices.conversation(requestBody);
    // print(requestBody);
    messages.insert(0, {'text': text, 'isMe': true});
    if (mounted) setState(() {});
  }

  receiveMessage(dynamic data) async {
    await Future.delayed(const Duration(seconds: 1));
    if (widget.chatroomid != userSD['id']) {
      messages.insert(0, {'text': data['text'], 'isMe': false});
      if (mounted) setState(() {});
    }
  }

  fetchChat() async {
    // var roomId = widget.isChatRoom == true ? widget.data['id'] : widget.data['chatRoomId'];

    try {
      // Make the network request using Dio
      final response =
          await dio.get('${Config.baseUrl}conversation/${widget.chatroomid}');
          

      // Check if the request was successful
      // if (response.data['status'] == 'success') {
      if (response.statusCode == 200) {

        List<dynamic> conversationHistory = response.data['data'];
        messages.clear(); // Clear the existing messages

        // Populate the messages list
        for (var conversation in conversationHistory) {
          messages.add({
            'text': conversation['message'],
            'isMe': conversation['senderId'] ==
                userSD['id'], // Check if the message is from the user
            'createdAt': DateTime.parse(conversation[
                'createdAt']), // Assuming you have a createdAt field
          });
        }

        if (mounted) {
          setState(() {}); // Update the UI
        }
      } else {
        // Handle the error scenario, if needed
        showToast(context,
            msg: 'Error fetching chat history: ${response.data['message']}');
      }
    } catch (e) {
      // Handle any exceptions that occur during the request
      print('Error fetching chat: $e');
      showToast(context, msg: 'Failed to fetch messages. Please try again.');
    }
  }

  onEmojiSelected(emoji.Emoji emoji) {
    textController
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
        TextPosition(offset: textController.text.length),
      );
  }

  toggleEmojiPicker() {
    _isEmojiPickerVisible = !_isEmojiPickerVisible;
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    socket!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    connectSocket();
    fetchChat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              height: 90,
              padding: const EdgeInsets.only(left: 12.0, top: 35),
              color: Colors.white,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      pop(context);
                    },
                    child: const Icon(Icons.arrow_back_outlined, size: 25),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: ClipOval(
                      child: CachedNetworkImage(
                          imageUrl: '',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                          errorWidget: (context, url, error) => const Center(
                                child: Icon(
                                  Icons.error_outline_outlined,
                                  color: Colors.grey,
                                ),
                              )),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   widget.isChatRoom == true
                        //       ? (widget. receverid == userSD['id']
                        //           ? userSD['id'] ?? 'Unknown'
                        //           : userSD['receiver']['name'] ?? 'Unknown')
                        //       : userSD['user']['name'] ?? 'Unknown',
                        //   style: const TextStyle(
                        //     fontFamily: 'cabin bold',
                        //     fontSize: 12,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            Container(
                              height: 6,
                              width: 6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              'Online',
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'cabin med',
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(10.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                var message = messages[index];
                var isMe = message['isMe'];
                var text = message['text'];
                var time = message['createdAt'] ?? DateTime.now();
                String formattedTime = DateFormat('h:mm a').format(time);

                return Container(
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.yellow : Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(15),
                        topRight: const Radius.circular(15),
                        bottomLeft: isMe
                            ? const Radius.circular(15)
                            : const Radius.circular(0),
                        bottomRight: isMe
                            ? const Radius.circular(0)
                            : const Radius.circular(15),
                      ),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: isMe
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: TextStyle(
                            color: isMe ? Colors.white : Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          formattedTime,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                            color: isMe ? Colors.white70 : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Column(
            children: [
              Container(
                height: 80,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: textController,
                          onSubmitted: sendMessage,
                          decoration: InputDecoration(
                            hintText: 'Type your message...',
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 15),
                            prefixIcon: IconButton(
                              icon: const Icon(Icons.emoji_emotions_outlined),
                              onPressed: toggleEmojiPicker,
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.photo_outlined),
                              onPressed: () {
                                // imageBottomSheet(context);
                              },
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                              ),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.yellow,
                        child: IconButton(
                          icon: const Icon(Icons.send, color: Colors.white),
                          onPressed: () {
                            sendMessage(textController.text);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (_isEmojiPickerVisible)
                SizedBox(
                  height: 230,
                  child: emoji.EmojiPicker(
                    onEmojiSelected:
                        (emoji.Category? category, emoji.Emoji emoji) {
                      onEmojiSelected(emoji);
                    },
                    config: emoji.Config(
                      height: 256,
                      emojiViewConfig: EmojiViewConfig(),
                      categoryViewConfig: emoji.CategoryViewConfig(),
                      skinToneConfig: emoji.SkinToneConfig(),
                      bottomActionBarConfig: emoji.BottomActionBarConfig(),
                      searchViewConfig: emoji.SearchViewConfig(),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  EmojiViewConfig() {}
}
