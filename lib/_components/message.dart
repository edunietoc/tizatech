import 'package:flutter/material.dart';
import 'package:tizatech/shared/constants.dart';

import '../models/messages.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({
    @required this.hasBeenRead,
    @required this.message,
    @required this.onTap,
    Key key,
  }) : super(key: key);

  final bool hasBeenRead;
  final Message message;
  final Function onTap;

  static const String _unreadPath = 'assets/images/messages/unread.png';
  static const String _readPath = 'assets/images/messages/read.png';

  @override
  Widget build(BuildContext context) => InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                hasBeenRead ? _readPath : _unreadPath,
                width: 40,
                height: 40,
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      message.userSender.halfName,
                      style: body2(context),
                    ),
                    Text(
                      message.title,
                      style: body2(context),
                    ),
                    Text(
                      message.message,
                      style: caption(context),
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
              Text(
                message.date,
                style: caption(context),
              ),
            ],
          ),

          /* isThreeLine: true,
          leading: Image.asset(hasBeenRead ? _readPath : _unreadPath),
          title: Text(message.title),
          subtitle: Text(message.message),

          trailing: Text(
            message.time,
          ),
          onTap: onTap, */
        ),
        onTap: onTap,
      );
}
