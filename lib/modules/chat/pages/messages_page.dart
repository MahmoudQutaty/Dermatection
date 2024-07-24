import 'package:dermatechtion/modules/chat/models/app.dart';
import 'package:dermatechtion/modules/chat/widgets/helpers.dart';
import 'package:dermatechtion/modules/chat/widgets/widgets.dart';
import 'package:dermatechtion/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import '../../../controllers/provider/auth.dart';
import '../chat_screen.dart';
import '../widgets/display_error_message.dart';
import 'contacts_page.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  late final channelListController = StreamChannelListController(
    client: StreamChatCore.of(context).client,
    filter: Filter.and(
      [
        Filter.equal('type', 'messaging'),
        Filter.in_('members', [
          StreamChatCore.of(context).currentUser!.id,
        ])
      ],
    ),
  );

  @override
  void initState() {
    channelListController.doInitialLoad();
    super.initState();
  }

  @override
  void dispose() {
    channelListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: PagedValueListenableBuilder<int, Channel>(
          valueListenable: channelListController,
          builder: (context, value, child) {
            return value.when(
                  (channels, nextPageKey, error) {
                if (channels.isEmpty) {
                  return  Center(
                    child: Text(
                      Auth.user=='patient' ?'So empty.\nGo and message your doctor.':"Wait until some patients text you.",
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return LazyLoadScrollView(
                  onEndOfPage: () async {
                    if (nextPageKey != null) {
                      channelListController.loadMore(nextPageKey);
                    }
                  },
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            return _MessageTile(
                              channel: channels[index],
                            );
                          },
                          childCount: channels.length,
                        ),
                      )
                    ],
                  ),
                );
              },
              loading: () => const Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (e) => DisplayErrorMessage(
                error: e,
              ),
            );
          },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: GlowingActionButton(
            color: kPrimaryColor,
            icon: CupertinoIcons.add,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => Dialog(
                    child: AspectRatio(
                      aspectRatio: 8/7,
                      child: ContactsPage(),
                    ),
                  )
              );
            }),
      ),
    );

    // return PagedValueListenableBuilder<int, Channel>(
    //   valueListenable: channelListController,
    //   builder: (context, value, child) {
    //     return value.when(
    //           (channels, nextPageKey, error) {
    //         if (channels.isEmpty) {
    //           return  Center(
    //             child: Text(
    //               Auth.user=='patient' ?'So empty.\nGo and message your doctor.':"Wait until some patients text you.",
    //               textAlign: TextAlign.center,
    //             ),
    //           );
    //         }
    //         return LazyLoadScrollView(
    //           onEndOfPage: () async {
    //             if (nextPageKey != null) {
    //               channelListController.loadMore(nextPageKey);
    //             }
    //           },
    //           child: CustomScrollView(
    //             slivers: [
    //               SliverList(
    //                 delegate: SliverChildBuilderDelegate(
    //                       (context, index) {
    //                     return _MessageTile(
    //                       channel: channels[index],
    //                     );
    //                   },
    //                   childCount: channels.length,
    //                 ),
    //               )
    //             ],
    //           ),
    //         );
    //       },
    //       loading: () => const Center(
    //         child: SizedBox(
    //           height: 100,
    //           width: 100,
    //           child: CircularProgressIndicator(),
    //         ),
    //       ),
    //       error: (e) => DisplayErrorMessage(
    //         error: e,
    //       ),
    //     );
    //   },
    // );
  }
}



class _MessageTile extends StatelessWidget {
  const _MessageTile({Key? key, required this.channel}) : super(key: key);


  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(ChatScreen.routeWithChannel(channel));
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.2
            )
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Avatar.medium(
                  url: Helpers.getChannelImage(channel, context.currentUser!),
                ),
              ),
              Expanded(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      Helpers.getChannelName(channel, context.currentUser!),
                      style: TextStyle(
                      letterSpacing: 0.2,
                      wordSpacing: 1.5,
                      fontWeight: FontWeight.w900,
                    ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                      child: _buildLastMessage(),
                  ),
                ],
              ),
              ),
              Padding(padding: const EdgeInsets.only(right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    _buildLastMessageAt(),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Center(
                      child: UnreadIndicator(
                        channel: channel,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLastMessage(){
    return BetterStreamBuilder<int>(
      stream: channel.state!.unreadCountStream,
      initialData: channel.state?.unreadCount ?? 0,
      builder: (context, count) {
        return BetterStreamBuilder<Message>(
          stream: channel.state!.lastMessageStream,
          initialData: channel.state!.lastMessage,
          builder: (context, lastMessage) {
            return Text(
              lastMessage.text ?? '',
              overflow: TextOverflow.ellipsis,
              style: (count > 0)
                ? const TextStyle(
                fontSize: 12,
                color: kPrimaryColor
              )
                  : const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              )
            );
          },
        );
      },

    );
  }

  Widget _buildLastMessageAt() {

    return BetterStreamBuilder <DateTime> (
      stream: channel.lastMessageAtStream,
      initialData: channel.lastMessageAt,
      builder: (context, data) {
        final lastMessageAt = data.toLocal();
        String stringDate;
        final now = DateTime.now();

        final startOfDay = DateTime(now.year, now.month, now.day);

        if (lastMessageAt.millisecondsSinceEpoch >= startOfDay.millisecondsSinceEpoch) {
          stringDate = Jiffy(lastMessageAt.toLocal()).jm;
        } else if (lastMessageAt.millisecondsSinceEpoch >=
        startOfDay.subtract(const Duration(days: 1)).millisecondsSinceEpoch) {
          stringDate = "YESTERDAY";
        } else if (startOfDay.difference(lastMessageAt).inDays < 7) {
          stringDate = Jiffy(lastMessageAt.toLocal()).EEEE;
        } else {
          stringDate = Jiffy(lastMessageAt.toLocal()).yMd;
        }
        return Text(
          stringDate,
          style: const TextStyle(
            fontSize: 11,
            letterSpacing: -0.2,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        );
      },
    );

  }

}
