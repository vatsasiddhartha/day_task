import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/task_model.dart';

class TaskService {
  final SupabaseClient _client = Supabase.instance.client;

  // CREATE TASK
  Future<void> addTask({
    required String title,
    String? date,
    String? time,
  }) async {
    final user = _client.auth.currentUser;

    print("USER: $user");
    print("TITLE: $title");
    print("DATE: $date");
    print("TIME: $time");

    if (user == null) {
      throw Exception("USER NOT LOGGED IN");
    }

    final response = await _client.from('tasks').insert({
      'title': title,
      'task_date': date,
      'task_time': time,
      'user_id': user.id,
    });

    print("INSERT RESPONSE: $response");
  }

  // READ TASKS
  Future<List<TaskModel>> fetchTasks() async {
    final response = await _client
        .from('tasks')
        .select()
        .order('created_at', ascending: false);

    return (response as List).map((e) => TaskModel.fromMap(e)).toList();
  }

  // UPDATE TASK
  Future<void> updateTask(String id, Map<String, dynamic> data) async {
    await _client.from('tasks').update(data).eq('id', id);
  }

  // TOGGLE COMPLETION
  Future<void> toggleTaskCompletion(String id, bool isCompleted) async {
    await _client
        .from('tasks')
        .update({'is_completed': !isCompleted})
        .eq('id', id);
  }
}
