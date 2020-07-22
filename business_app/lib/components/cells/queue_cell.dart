import 'package:business_app/components/cells/slideable_list_cell.dart';
import 'package:flutter/material.dart';
import 'package:business_app/business_app/models/queues.dart';

// class QueueCell extends SlideableListCell {
//   final Queue queue;
//   final Future<bool> Function() onOpen;
//   final Future<bool> Function() onDelete;

//   QueueCell({Key key, @required this.queue, this.onOpen, this.onDelete, Function onTap})
//     : super(
//       key: key,
//       title: queue.name ?? "New Queue",
//       subheading: (){
//         switch (queue.state) {
//           case QueueState.active:
//             //final numInLine = queue.numWaiting;
//             final numInLine = -1;
//             switch (numInLine) {
//               case 0:
//                 return "Queue is Empty";
//               case 1:
//                 return "1 Person is in Line";
//               default:
//                 return "$numInLine People are in Line.";
//             }
//             break;
//           case QueueState.inactive:
//             return null;
//         }
//       }(),
//       body: queue.description ?? "Swipe from the left to delete this queue and swipe right to see more details.",
//       isActive: () {
//         switch (queue.state) {
//           case QueueState.active:
//             return true;
//           case QueueState.inactive:
//             return false;
//         }
//       }(),
//       isSelected: false,
//       getPrimaryText: "Open",
//       onPrimarySwipe: onOpen,
//       onSecondarySwipe: onDelete,
//       relativeSize: SlideableListCellSize.big,
//       onTap: onTap,
//   );
// }

// enum QueueEntryCellSize {
//   medium, small
// }

// class QueueEntryCell extends SlideableListCell {
//   final QueuePerson queueEntry;
//   final Future<bool> Function() onDelete;
//   final Future<bool> Function() onNotify;
  
//   QueueEntryCell({Key key, this.onDelete, this.onNotify, this.queueEntry, Function onTap, QueueEntryCellSize size})
//     : super(
//         key: key,
//         isSelected: (){
//           switch (queueEntry.state) {
//             case QueueEntryState.pendingNotification:
//             case QueueEntryState.notified:
//               return true;
//             case QueueEntryState.waiting:
//             case QueueEntryState.pendingDeletion:          
//             case QueueEntryState.deleted:          
//               return false;
//           }
//         }(),
//         getPrimaryText: "Notify",
//         onPrimarySwipe: onNotify,
//         onSecondarySwipe: onDelete,
//         title: queueEntry.name,
//         body: queueEntry.note ?? "",
//         relativeSize: (){
//           switch (size) {
//             case QueueEntryCellSize.small:
//               return SlideableListCellSize.small;
//             case QueueEntryCellSize.medium:
//               return SlideableListCellSize.medium;
//         }
//       }(),
//       onTap: onTap,
//     );
// }
