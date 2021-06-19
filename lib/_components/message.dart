import 'package:flutter/material.dart';

import '../models/messages.dart';
import '../shared/constants.dart';
import '../shared/utils.dart';

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

  final String _unreadPath = 'assets/images/messages/unread.png';
  final String _readPath = 'assets/images/messages/read.png';

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          margin: EdgeInsets.only(bottom: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                hasBeenRead ? _readPath : _unreadPath,
                width: 40,
                height: 40,
              ),
              /* Image.network(
                '$imageBaseUrl${message.userSender.picturePath}',
                width: 40,
                height: 40,
              ), */
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      message.userSender.halfName,
                      style: body2(context).copyWith(
                          fontWeight:
                              hasBeenRead ? FontWeight.w400 : FontWeight.w500),
                    ),
                    Text(
                      message.title,
                      style: body2(context).copyWith(
                          fontWeight:
                              hasBeenRead ? FontWeight.w400 : FontWeight.w500),
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
                parseDate(message.date, message.time),
                style: caption(context).copyWith(
                    fontWeight:
                        hasBeenRead ? FontWeight.w400 : FontWeight.w500),
              ),
            ],
          ),
        ),
      );
}
