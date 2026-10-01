import 'package:flutter/material.dart';

class CommentOverlay extends StatefulWidget {
  final Function(String) onSend;

  const CommentOverlay({
    super.key,
    required this.onSend,
  });

  @override
  State<CommentOverlay> createState() => _CommentOverlayState();
}

class _CommentOverlayState extends State<CommentOverlay> {
  final TextEditingController controller = TextEditingController();

  bool isPremiumMode = false;
  bool showEmojiPanel = false;

  final String userName = "Me";

  final List<String> emojis = [
    "😀","😂","😍","🔥","❤️",
    "😎","😭","👍","🎉","😡"
  ];

  void addEmoji(String emoji) {
    controller.text += emoji;
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );
  }

  void sendMessage() {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    if (isPremiumMode) {
      _showFloatingComment(userName, text);
    }

    widget.onSend(text);
    controller.clear();
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.pop(context);
  }

  void _showFloatingComment(String name, String text) {
    final overlay = Overlay.of(context);

    final entry = OverlayEntry(
      builder: (context) {
        return _FloatingChat(name: name, text: text);
      },
    );

    overlay.insert(entry);

    Future.delayed(const Duration(seconds: 5), () {
      entry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
        decoration: const BoxDecoration(
          color: Color(0xff121212),
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              if (showEmojiPanel)
                SizedBox(
                  height: 160,
                  child: GridView.builder(
                    itemCount: emojis.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => addEmoji(emojis[index]),
                        child: Center(
                          child: Text(
                            emojis[index],
                            style: const TextStyle(fontSize: 26),
                          ),
                        ),
                      );
                    },
                  ),
                ),

              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: isPremiumMode
                            ? Colors.red.withOpacity(0.12)
                            : Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Transform.scale(
                            scale: 0.65,
                            child: Switch(
                              value: isPremiumMode,
                              activeThumbColor: Colors.red,
                              onChanged: (val) {
                                setState(() {
                                  isPremiumMode = val;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: controller,
                              autofocus: true,
                              style: TextStyle(
                                color: isPremiumMode
                                    ? Colors.red
                                    : Colors.white,
                              ),
                              decoration: InputDecoration(
                                hintText: "Write a comment...",
                                hintStyle: TextStyle(
                                  color: isPremiumMode
                                      ? Colors.redAccent
                                      : Colors.white54,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showEmojiPanel = !showEmojiPanel;
                              });
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(6),
                              child: Icon(
                                Icons.emoji_emotions,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: sendMessage,
                    child: Container(
                      height: 44,
                      width: 44,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xffFF4D9D), Color(0xff7B61FF)],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.send, color: Colors.white, size: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FloatingChat extends StatefulWidget {
  final String name;
  final String text;

  const _FloatingChat({required this.name, required this.text});

  @override
  State<_FloatingChat> createState() => _FloatingChatState();
}

class _FloatingChatState extends State<_FloatingChat>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    );

    _animation = Tween<double>(begin: 1.2, end: -1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Positioned(
                top: MediaQuery.of(context).size.height * 0.4,
                left: width * _animation.value,
                child: child!,
              );
            },
            child: Container(
              constraints: const BoxConstraints(maxWidth: 260),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xffFF4D9D), Color(0xff7B61FF)],
                ),
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.45),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${widget.name}: ",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      widget.text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}