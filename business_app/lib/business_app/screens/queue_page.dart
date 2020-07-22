import 'package:business_app/business_app/services/services.dart';
import 'package:business_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:business_app/business_app/models/queues.dart';
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
    return Consumer<QueuePeople>(
        builder: (context, qpeople, _) {
          qpeople.start();
          return SlideableList(
            onPlusTap: (){
              queue.people.add2Queue(name: "NAMES", id: 7, phone: "8888888888");
              // queue.add(QueueEntry(name: "John Doe"));
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
            cells: qpeople.body.map((element) =>
              ChangeNotifierProvider.value(
                  value: element,
                  child: Consumer<QueuePerson>(
                    builder: (context, entry, _) {
                      // Todo, index?
                      var index = 10;
                      return QueueEntryCell(
                        queueEntry: entry,
                        size: (index < 3)
                            ? QueueEntryCellSize.medium
                            : QueueEntryCellSize.small,
                        
                        onDelete: () {
                          queue.people.remove(entry.id);
                          return Future.value(true);
                        },
                        
                        onNotify: () {
                          entry.state = QueueEntryState.pendingNotification;
                          return Future.value(false);
                        },
                      );
                    },
                  ),
                )
            ).toList()
          );
        },
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
                          Consumer<Queue>(
                            builder: (context, q, _){
                              return Text(
                                queue.name ?? "New Queue",
                                style: MyStyles.of(context).textThemes.h2,
                              );
                            }
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
                          Consumer<Queue>(
                            builder: (context, q, _){
                              String queueCode = q.code ?? "...";
                              return  Text(
                                "Code: $queueCode",
                                style: MyStyles.of(context).textThemes.h4,
                              );
                            }
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 7),
                  Container(
                    alignment: Alignment.center,
                    child: Consumer<QueuePeople>(
                      builder: (context, qpeople, _){
                        return  Text(
                          "Waiting ${qpeople.numWaiting} | Notified ${qpeople.numNotified} | Completed ${qpeople.numCompleted}",
                          style: MyStyles.of(context).textThemes.bodyText3,
                        );
                      }
                    ),
                  )
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
