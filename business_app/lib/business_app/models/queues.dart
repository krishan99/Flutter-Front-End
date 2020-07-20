import 'package:business_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:business_app/business_app/services/services.dart';


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

  String get name => _name;
  String get note => _note;

  QueueEntryState _state;
  QueueEntryState get state => _state;
  set state(QueueEntryState newValue) {
    _state = newValue;
    notifyListeners();
  }

  Future<bool> removeFromServer() async{}

  QueuePerson({
    @required this.id,
    String name,
    String note,
    QueueEntryState state = QueueEntryState.waiting,
  }) {
    this._name = name;
    this._note = note;
    this._state = state;
  }
}

class QueuePeople with ChangeNotifier{
  List<QueuePerson> theline = new List<QueuePerson>();
  List<QueuePerson> get body => theline;

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
    return theline.where((element) => states.contains(element.state)).length;
  }

  int _getNumOfState(QueueEntryState state) {
    return _getNumOfStates([state]);
  }

  void remove(int id) async{
    int index = -1;
    for(int i=0; i<theline.length; i++){
      if(theline[i].id == id){
        index = i;
        break;
      }
    }
    if(index == -1){
      print("Invalid id to remove");
      return;
    }
    bool done =  await theline[index].removeFromServer();
    if(done){
      theline.removeAt(index);
      notifyListeners();
    }
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
    this._people = new QueuePeople();
  }
}

class AllQueuesInfo with ChangeNotifier {
  final BusinessAppServer server;
  var queues = new Map<int, Queue>();
  Iterable<Queue> get body => queues.values;

  retrieveServer() async {
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
  }

  makeQueue(String name, String description) async {
    Map<String, dynamic> n = await server.makeQueue(name, description);
    int k = n["qid"];
    queues[k] = new Queue(id: k);
    queues[k].update(n);
    notifyListeners();
  }

  deleteQueue(int qid) async {
    bool done = await server.deleteQueue(qid);
    if(done){
      queues.remove(qid);
      notifyListeners();
    }
  }

  refresh() async {
    retrieveServer();
    notifyListeners();
  }

  AllQueuesInfo({@required this.server});
}