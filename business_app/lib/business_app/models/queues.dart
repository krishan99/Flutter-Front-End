import 'package:flutter/material.dart';
import 'package:business_app/business_app/services/services.dart';

class QueueInfo with ChangeNotifier{
  final int id;
  //int get id_ => id;
  String name;
  String get name_ => name;
  bool active;
  bool get active_ => active;
  String description;
  String get description_ => description;
  String code;
  String get code_ => code;

  void update(Map<String, dynamic> info){
    name = info["qname"] ?? name;
    description = info["description"] ?? description;
    code = info["code"] ?? code;
    notifyListeners();
  }

  QueueInfo({@required this.id});
}

class AllQueuesInfo with ChangeNotifier {
  final BusinessAppServer server;
  var queues = new Map<int, QueueInfo>();
  Iterable<QueueInfo> get body => queues.values;

  Future<bool> retrieveServer() async {
    var serverQueues = await server.getListofQueues();
    // update info based on server
    for(var i=0; i<serverQueues.length; i++){
      int k = serverQueues[i]["qid"];
      if(!queues.containsKey(k)){
        queues[k]=new QueueInfo(id: k);
      }
      queues[k].update(serverQueues[i]);
    }
    // delete anything not on server anymore
    var keys = queues.keys;
    for(var k in keys){
      bool there = false;
      for(var j=0; j<serverQueues.length; j++){
        if(serverQueues[j]["qid"]==k){
          there=true;
          break;
        }
      }
      if(!there) queues.remove(k);
    }
    return true;
  }

  void makeQueue(String name, String description) async {
    Map<String, dynamic> n = await server.makeQueue(name, description);
    int k = n["qid"];
    queues[k] = new QueueInfo(id: k);
    queues[k].update(n);
    notifyListeners();
  }

  void deleteQueue(int qid) async {
    bool done = await server.deleteQueue(qid);
    if(done){
      queues.remove(qid);
      notifyListeners();
    }
  }

  void refresh() async {
    retrieveServer();
    notifyListeners();
  }

  AllQueuesInfo({@required this.server});
}