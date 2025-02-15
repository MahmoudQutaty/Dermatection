import 'dart:async';

import 'package:dermatechtion/modules/chat/models/app.dart';
import 'package:dermatechtion/modules/chat/models/message_data.dart';
import 'package:dermatechtion/modules/chat/widgets/display_error_message.dart';
import 'package:dermatechtion/modules/chat/widgets/glowing_action_button.dart';
import 'package:dermatechtion/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'widgets/avatar.dart';
import 'widgets/helpers.dart';
import 'widgets/icon_buttons.dart';

class ChatScreen extends StatefulWidget {

  static Route routeWithChannel(Channel channel) => MaterialPageRoute(
    builder: (context) => StreamChannel(
      channel: channel,
      child: const ChatScreen(),
    ),
  );

  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  late StreamSubscription<int> unreadCountSubscription;

  @override
  void initState() {
    super.initState();

    unreadCountSubscription = StreamChannel.of(context)
    .channel
    .state!
    .unreadCountStream
    .listen(_unreadCountHandler);
  }

  Future<void> _unreadCountHandler(int count) async {
    if (count > 0) {
      await StreamChannel.of(context).channel.markRead();
    }
  }

  @override
  void dispose() {
    unreadCountSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
            icon: CupertinoIcons.back,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
         title: const _AppBarTitle(),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: IconBorder(
                icon: CupertinoIcons.video_camera_solid ,
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
              child: IconBorder(
                icon: CupertinoIcons.phone_solid,
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: MessageListCore(
              loadingBuilder: (context) {
                return const Center(child: CircularProgressIndicator(),);
              },
              emptyBuilder: (context) => const SizedBox.shrink(),
              errorBuilder: (context, error) =>
                DisplayErrorMessage(),
              messageListBuilder: (context, messages) =>
                _MessageList(messages: messages),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 14.0),
            child: _ActionBar(),
          ),
        ],
      ),
    );
  }
}


class _MessageList extends StatelessWidget {
  const _MessageList({
    Key? key,
    required this.messages,
}) : super(key: key);

  final List<Message> messages;

  @override

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
          itemBuilder: (context, index) {
            if (index < messages.length) {
              final message = messages[index];
              if (message.user?.id == context.currentUser?.id) {
                return _MessageOwnTile(message: message,);
              } else {
                return _MessageTile(message: message,);
              }
            } else {
              return const SizedBox.shrink();
            }
          },
          separatorBuilder: (context, index) {
            if (index == messages.length - 1) {
              return _DateLabel(dateTime: messages[index].createdAt);
            }
            if (messages.length == 1) {
              return const SizedBox.shrink();
            } else if (index >= messages.length - 1) {
              return const SizedBox.shrink();
            } else if (index <= messages.length) {
              final message = messages[index];
              final nextMessage = messages[index + 1];
              if (!Jiffy(message.createdAt.toLocal())
              .isSame(nextMessage.createdAt.toLocal(), Units.DAY)) {
                return _DateLabel(dateTime: message.createdAt);
              } else {
                return const SizedBox.shrink();
              }
            } else {
              return const SizedBox.shrink();
            }
          },
          itemCount: messages.length + 1,
        reverse: true,
      ),
    );
  }
}

class _DateLabel extends StatefulWidget {
  const _DateLabel({
    Key? key,
    required this.dateTime,
  }) : super(key: key);

  final DateTime dateTime;

  @override
  State<_DateLabel> createState() => _DateLabelState();
}

class _DateLabelState extends State<_DateLabel> {
  late String dayInfo;
  @override
  void initState() {
    final createdAt = Jiffy(widget.dateTime);
    final now = DateTime.now();

    if (Jiffy(createdAt).isSame(now,Units.DAY)) {
      dayInfo = 'TODAY';
    } else if (Jiffy(createdAt).isSame(now.subtract(const Duration(days: 1)), Units.DAY)) {
      dayInfo = 'YESTERDAY';
    } else if (Jiffy(createdAt).isAfter(now.subtract(const Duration(days: 7)), Units.DAY)) {
      dayInfo = createdAt.EEEE;
    } else if (Jiffy(createdAt).isAfter(Jiffy(now).subtract(years: 1), Units.DAY)) {
      dayInfo = createdAt.MMMd;
    } else {
      dayInfo = createdAt.MMMd;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 12),
            child: Text(
              dayInfo,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: kTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle({
    Key? key
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final channel = StreamChannel.of(context).channel;
    return Row(
      children: [
        Avatar.small(
          url: Helpers.getChannelImage(channel, context.currentUser!),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Helpers.getChannelName(channel, context.currentUser!),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14,color: kTextColor),
              ),
              const SizedBox(height: 2),
              BetterStreamBuilder(
                stream: channel.state!.membersStream,
                initialData: channel.state!.members,
                builder: (context, data) => ConnectionStatusBuilder(
                  statusBuilder: (context, status) {
                    switch (status) {
                      case ConnectionStatus.connected:
                        return _buildConnectedTitleState(context, data);
                      case ConnectionStatus.connecting:
                        return const Text(
                          'Connecting',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        );
                      case ConnectionStatus.disconnected:
                        return const Text(
                          'Offline',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        );
                      default:
                        return const SizedBox.shrink();
                    }
                  },
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildConnectedTitleState(BuildContext context, List<Member>? members) {
    Widget? alternativeWidget;
    final channel = StreamChannel.of(context).channel;
    final memberCount = channel.memberCount;
    if (memberCount != null && memberCount >2) {
      var text = 'Members: $memberCount';
      final watchCount = channel.state?.watcherCount ?? 0;
      if(watchCount >0) {
        text = 'watchers$watchCount';
      }
      alternativeWidget = Text(text);
    } else {
      final userId = StreamChatCore.of(context).currentUser?.id;
      final otherMember = members?.firstWhereOrNull((element) => element.userId != userId);

      if (otherMember != null) {
        if (otherMember.user?.online ==true) {
          alternativeWidget = const Text(
            'Online',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          );
        } else {
          alternativeWidget = Text(
            'Last online: '
                '${Jiffy(otherMember.user?.lastActive).fromNow()}',
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          );
        }
      }
    }
    return TypingIndicator(
      alternativeWidget: alternativeWidget,
    );
  }


}

class TypingIndicator extends StatelessWidget {
  const TypingIndicator({Key? key, this.alternativeWidget}) : super(key: key);

  final Widget? alternativeWidget;

  @override
  Widget build(BuildContext context) {
    final channelState = StreamChannel.of(context).channel.state!;

    final altWidget = alternativeWidget ?? const Offstage();

    return BetterStreamBuilder <Iterable<User>>(
      initialData: channelState.typingEvents.keys,
      stream: channelState.typingEventsStream
      .map((typing) => typing.entries.map((e) => e.key)),
      builder: (context, data){
        return Align(
          alignment: Alignment.centerLeft,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: data.isNotEmpty == true
              ? const Align(
              alignment: Alignment.centerLeft,
              key: ValueKey('typing-text'),
              child: Text(
                "Typing message",
                maxLines: 1,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
                : Align(
              alignment: Alignment.centerLeft,
              key: const ValueKey('altwidget'),
              child: altWidget,
            )
          ),
        );
      },
    );
  }
}

class ConnectionStatusBuilder extends StatelessWidget {
  const ConnectionStatusBuilder({
    Key? key,
    required this.statusBuilder,
    this.connectionStatusStream,
    this.errorBuilder,
    this.loadingBuilder,
}) : super(key: key);

  final Stream<ConnectionStatus>? connectionStatusStream;

  final Widget Function(BuildContext context, Object? error)? errorBuilder;

  final WidgetBuilder? loadingBuilder;

  final Widget Function(BuildContext context, ConnectionStatus status) statusBuilder;

  @override

  Widget build(BuildContext context) {
    final stream = connectionStatusStream ??
    StreamChatCore.of(context).client.wsConnectionStatusStream;

    final client = StreamChatCore.of(context).client;

    return BetterStreamBuilder(
      initialData: client.wsConnectionStatus,
      stream: stream,
      noDataBuilder: loadingBuilder,
      errorBuilder: (context, error) {
        if (errorBuilder != null) {
          return errorBuilder!(context, error);
        }
        return const Offstage();
      },
      builder: statusBuilder,
    );
  }
}


class _MessageTile extends StatelessWidget {
  const _MessageTile({
    Key? key,
    required this.message,
  }) : super(key: key);
  final Message message;
  static const _borderRadius = 26.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  topRight: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Text(message.text ?? ''),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                Jiffy(message.createdAt.toLocal()).jm,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class _MessageOwnTile extends StatelessWidget {
  const _MessageOwnTile({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;

  static const _borderRadius = 26.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                  bottomLeft: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Text(message.text ?? '',
                    style: const TextStyle(
                      color: kBackgroundColor,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                Jiffy(message.createdAt.toLocal()).jm,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionBar extends StatefulWidget {
  const _ActionBar({Key? key}) : super(key: key);

  @override
  __ActionBarState createState() => __ActionBarState();
}

class __ActionBarState extends State<_ActionBar> {
  final TextEditingController controller = TextEditingController();

  //Timer? _debounce;

  Future<void> _sendMessage() async {
    if (controller.text.isNotEmpty) {
      StreamChannel.of(context).channel.sendMessage(Message(text: controller.text));
      controller.clear();
      //FocusScope.of(context).unfocus();
    }
  }

  // void _onTextChange() {
  //   if (_debounce?.isActive ?? false) _debounce?.cancel();
  //   _debounce = Timer(const Duration(seconds: 1), () {
  //     if (mounted) {
  //       StreamChannel.of(context).channel.keyStroke();
  //     }
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   controller.addListener(_onTextChange);
  // }

  @override
  void dispose() {
    controller.dispose();
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 2,
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(
                CupertinoIcons.camera_fill,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: TextField(
                controller: controller,
                onChanged: (val) {
                  StreamChannel.of(context).channel.keyStroke();
                },
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(
                  hintText: 'Type something...',
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 12,
              right: 24.0,
            ),
            child: GlowingActionButton(
              color: kSecondaryColor,
              icon: Icons.send_rounded,
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}