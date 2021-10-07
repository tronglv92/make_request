import 'package:meta/meta.dart';

class TodoResponse {
  final String id;
  final String task;
  final String extraNote;
  final bool complete;

  TodoResponse(
      {required this.id,
        required this.task,
        required this.extraNote,
        required this.complete});

  factory TodoResponse.fromMap(Map<String, dynamic> data, String documentId) {
    final String task = data['task'] as String;
    final String extraNote = data['extraNote'] as String;
    final bool complete = data['complete'] as bool;

    return TodoResponse(
        id: documentId, task: task, extraNote: extraNote, complete: complete);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'task': task,
      'extraNote': extraNote,
      'complete': complete,
    };
  }
}
