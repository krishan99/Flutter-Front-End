import 'package:flutter/material.dart';
import 'package:business_app/business_app/services/services.dart';
import 'dart:async';
import 'dart:collection';

BusinessAppServer server = new BusinessAppServer();

enum QueueEntryState {
  notified,
  pendingNotification,
  waiting,
  pendingDeletion,
  deleted
}

class QueuePerson with ChangeNotifier{
  int id;
  String _name;
  String _note;
  String _phone;
  String _time;

  String get name => _name;
  String get note => _note;
  String get phone => _phone;

  QueueEntryState _state;
  QueueEntryState get state => _state;
  set state(QueueEntryState newValue) {
    _state = newValue;
    notifyListeners();
  }

  void update(Map<String, dynamic> info){
    _name = info["name"] ?? _name;
    _note = info["note"] ?? _note;
    _phone = info["phone"] ?? _phone;
    _time = info["created"] ?? _time;
  }

  QueuePerson({
    @required this.id,
    String name,
    String note,
    QueueEntryState state = QueueEntryState.waiting,
  }) {
    this._name = name;
    this._note = note;
    this._state = state;
    this._phone = phone;
  }
}

class QueuePeople with ChangeNotifier{
  final int id;
  // this is an ordered map
  var theline = new SplayTreeMap<int, QueuePerson>();
  Iterable<QueuePerson> get body => theline.values;

  void updateFromSever(List<dynamic> serverLine){
    for(var i=0; i < serverLine.length; i++){
      int k = serverLine[i]["id"];
      if(!theline.containsKey(k)){
        theline[k]=new QueuePerson(id: k);
      }
      theline[k].update(serverLine[i]);
    }
    // delete anything not on server anymore
    var keys = theline.keys;
    var toRemove = [];
    for(var k in keys){
      bool there = false;
      for(var j=0; j<serverLine.length; j++){
        if(serverLine[j]["id"]==k){
          there=true;
          break;
        }
      }
      if(!there) toRemove.add(k);
    }

    toRemove.forEach((k) {theline.remove(k);});
  }

  void start() {
    BusinessAppServer.joinRoom(id);
  }

  int get numWaiting {
    return _getNumOfState(QueueEntryState.waiting);
  }
  
  int get numNotified {
    return _getNumOfStates([QueueEntryState.notified, QueueEntryState.pendingNotification]);
  }

  int get numCompleted {
    return _getNumOfStates([QueueEntryState.notified, QueueEntryState.pendingDeletion]);
  }

  int _getNumOfStates(List<QueueEntryState> states) {
    return theline.keys.where((k) => states.contains(theline[k].state)).length;
  }

  int _getNumOfState(QueueEntryState state) {
    return _getNumOfStates([state]);
  }

  void remove(int person_id) async{
    if(!theline.containsKey(person_id)){
      print("Invalid id to remove");
      return;
    }

    bool done =  await server.deletePerson(id, person_id);
    if(done){
      theline.remove(id);
      notifyListeners();
    }
  }

  QueuePeople({@required this.id}){
    print("update $id");
    BusinessAppServer.socket.on("update $id", (data) {
        updateFromSever(data["line"]);
        notifyListeners();
    });
  }
}

enum QueueState {
  active, inactive
}

class Queue with ChangeNotifier{
  final int id;
  String _name;
  String _description;
  String _code;
  QueueState _state;
  QueuePeople _people;
  
  String get name => _name;
  String get description => _description;
  String get code => _code;
  QueueState get state => _state;
  set state(QueueState newValue) {
    _state = newValue;
    notifyListeners();
  }
  QueuePeople get people => _people;

  void update(Map<String, dynamic> info){
    _name = info["qname"] ?? _name;
    _description = info["description"] ?? _description;
    _code = info["code"] ?? _code;
    notifyListeners();
  }

  Queue({@required this.id}){
    this._name = "New Queues";
    this._description = "Swipe from the left to delete this queue and swipe right to see more details.";
    this._state = QueueState.inactive;
    this._code = "...";
    this._people = new QueuePeople(id: this.id);
  }
}

class AllQueuesInfo with ChangeNotifier {
  final BusinessAppServer server;
  var queues = new Map<int, Queue>();
  Iterable<Queue> get body => queues.values;

  Future<bool> retrieveServer() async {
    var serverQueues = await server.getListofQueues();
    // update info based on server
    for(var i=0; i<serverQueues.length; i++){
      int k = serverQueues[i]["qid"];
      if(!queues.containsKey(k)){
        queues[k]=new Queue(id: k);
      }
      queues[k].update(serverQueues[i]);
    }
    // delete anything not on server anymore
    var keys = queues.keys;
    var toRemove = [];
    for(var k in keys){
      bool there = false;
      for(var j=0; j<serverQueues.length; j++){
        if(serverQueues[j]["qid"]==k){
          there=true;
          break;
        }
      }
      if(!there) toRemove.add(k);
    }
    toRemove.forEach((k) {queues.remove(k);});
    return true;
  }

  // currently doesn't really do anything
  // meant to be called whenever dashboard shown
  void leaveRooms() async {
    BusinessAppServer.leaveRoom();
  }

  Future<bool> makeQueue(String name, String description) async {
    try{
      Map<String, dynamic> n = await server.makeQueue(name, description);
      int k = n["qid"];
      queues[k] = new Queue(id: k);
      queues[k].update(n);
      notifyListeners();
      return true;
    } catch(e) {
      print('exception caught while making queue: $e');
      return false;
    }
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