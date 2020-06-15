import 'package:business_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:business_app/models/models.dart';
import 'package:business_app/components/components.dart';
import 'package:business_app/theme/themes.dart';
import 'package:provider/provider.dart';

class QueuePage extends StatelessWidget {
  final Queue queue;

  const QueuePage({
    Key key,
    @required this.queue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideableList(
      onPlusTap: (){
        queue.add(QueueEntry(name: "John Doe"));
      },
      header: SliverPersistentHeader(
        pinned: true,
        delegate: _SliverAppBarDelegate(
          color: MyStyles.of(context).colors.background2,
          queue: queue,
          minExtent: 100.0,
          maxExtent: 125,
        ),
      ),
      cells: mapIndexed(queue, (index, e) {
        final QueueEntry entry = e as QueueEntry;
        return ChangeNotifierProvider.value(
          value: entry,
          child: Consumer<QueueEntry>(
            builder: (context, entry, _) {
              return QueueEntryCell(
                queueEntry: entry,
                size: (index < 3)
                    ? QueueEntryCellSize.medium
                    : QueueEntryCellSize.small,
                
                onDelete: () {
                  queue.remove(entry);
                  return Future.value(true);
                },
                
                onNotify: () {
                  entry.state = QueueEntryState.pendingNotification;
                  return Future.value(false);
                },
              );
            },
          ),
        );
      }).toList()
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Color color;
  final Queue queue;
  final double minExtent;
  final double maxExtent;

  const _SliverAppBarDelegate(
      {this.color, this.queue, this.minExtent, this.maxExtent});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    print(shrinkOffset);
    return Container(
      color: color,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                                size: 30,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            queue.name,
                            style: MyStyles.of(context).textThemes.h2,
                          ),
                          Expanded(
                              child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.settings, size: 30)))
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 42),
                          Text(
                            "Code: ${queue.code}",
                            style: MyStyles.of(context).textThemes.h4,
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 7),
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Waiting ${queue.numWaiting} | Notified ${queue.numNotified} | Completed ${queue.numCompleted}",
                        style: MyStyles.of(context).textThemes.bodyText3,
                      ))
                ],
              ),
            ),
          ]),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
